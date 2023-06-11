import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:smartcity/core/error/exceptions.dart';
import 'package:smartcity/features/operating/data/models/Route.dart';
import 'package:smartcity/features/operating/data/models/bin.dart';
import 'package:smartcity/features/operating/data/models/plan.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/domain/entities/route.dart';
import 'package:smartcity/features/operating/domain/entities/plan.dart';

abstract class BinRemoteDataSource {
  Future<RouteEnt> getRoute();

  Future<List<Bin>> getAllBins();

  Future<Bin> getBin(String id);

  Future<Plan> getPlan();

  Future<bool> addOperation(Bin bin) ;
}

class BinReamotDataSourceImp implements BinRemoteDataSource {
  static bool hasroute = false;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth ;

  BinReamotDataSourceImp({required this.firebaseFirestore , required this.firebaseAuth});

  @override
  Future<List<Bin>> getAllBins() async {
    var snapshot = await firebaseFirestore.collection('Bins').get();
    final List<BinModel> binModels = [];
    snapshot.docs.map((doc) {
      binModels
          .add(BinModel.fromJson({'id': doc.id.toString(), ...doc.data()}));
    }).toList();
    debugPrint(binModels.toString());
    return binModels;
  }
  @override
  
  Future<Bin> getBin(String id) async {
    var query = await firebaseFirestore.collection("Bins").doc(id).get() ;
    var data = query.data() ;
    if(data != null ){
      return BinModel.fromJson(
          {
            "id" : query.id ,
            'status' : data['status'] ,
            'location' : data["location"],
            'name' : data['name']
          }
      );
    }else{
      throw ServerException() ;
    }

  }

  // FirebaseAuth.instance.currentUser!.uid.toString()
  @override
  Future<PlanModel> getPlan() async {
   var query = await  firebaseFirestore.collection('Plan').where( 'userid', isEqualTo: firebaseAuth.currentUser!.uid).get() ;
   var data = query.docs.first.data() ;
   var siteName = await  firebaseFirestore.collection('sites').doc(data['siteid']).get() ;
   if(data != null){
     return PlanModel.fromJson(
         {
           'id' : query.docs.first.id.toString()  ,
           'siteid': siteName.data()!['name'] ,
           'time' : data['plandate'],
           'drivers' : 'drivers'
         }
     );
   }else {
     throw ServerException() ;
   }
  }

  @override
  Future<RouteEnt> getRoute() async {

    Location location = Location.instance ;
    LocationData locationdata  = await location.getLocation() ;

    List<Bin> waypoints = await routeBins() ;
    if(waypoints.isEmpty){
      throw EmptyModelException() ;
    }
    debugPrint("this is the waypoints" + waypoints.toString());
    var waypointvalid =
        waypoints.map((e) => "${e.latitude}%2C${e.longitude}").join("|");
    var endPointUrl = Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/"
        "json?origin=${locationdata.latitude}%2C${locationdata.longitude}&destination=${waypoints.last.latitude}%2C${waypoints.last.longitude}&"
        "waypoints=optimize:true|$waypointvalid&"
        "key=AIzaSyA8jPb11SmcuGSgz9DIHlkSL05GIUjhSqI");
      final response = await http.post(endPointUrl);
        if (response.statusCode == 200 && waypoints.isNotEmpty ) {
         return RouteModel.fromJson({
            "polyline" : jsonDecode(response.body)["routes"][0]['overview_polyline']['points'] ,
            "bins" : waypoints ,
            "distance": "summary" ,
            "duration" : "summary"
          }
          );

      }
        throw ServerException() ;
  }


  Future<List<Bin>> routeBins()  async {
    List<Bin> bins = [] ;
    String id =FirebaseAuth.instance.currentUser!.uid ;
    const url = 'https://us-central1-smartcity-91034.cloudfunctions.net/getBinsall';
    final headers = {
      'Authorization': 'bearer ${FirebaseAuth.instance.currentUser!.getIdToken()}',
      'Content-Type': 'application/json',
    };
    final jsondata = {'id': id};
    final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(jsondata));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body)["documents1"] as List ;
      debugPrint(data.toString());
        for (var id in data.last["binsids"]){
          var bin = await getBin(id);
         if( double.parse(bin.status) < 25){
           continue ;
        }else {
           bins.add(await getBin(id)) ;
         }
        }


      return bins ;
    }else {
      throw ServerException();
    }

  }

  @override
  Future<bool> addOperation(Bin bin) async {
    var query ;
    try {
      query = await firebaseFirestore.collection('operation').add({
        'binid': bin.id ,
        'driverid' : FirebaseAuth.instance.currentUser!.uid ,
        'operationtime' : DateTime.now()
      });
    } on Exception catch (e) {
      throw ServerException() ;
    }

    if(query.id.isNotEmpty){
      return true ;
    }else{
      return false ;
    }

  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartcity/core/error/exceptions.dart';
import 'package:smartcity/features/login/data/models/user_model.dart';


abstract class UserRemoteDataSource {
  Future<UserModel> getUser() ;
  Future<Unit> login(String userName, String password);

  Future<List<UserModel>> getAllUsers();

  Future<Unit> updateUser(UserModel user);

  Future<Unit> addUser(UserModel user);

  Future<Unit> logOut();
}

class UserReamotDataSourceImp implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore  = FirebaseFirestore.instance;
  UserReamotDataSourceImp({required this.firebaseAuth});
  @override
  Future<Unit> addUser(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Unit> logOut() async  {
    await firebaseAuth.signOut();
    if(firebaseAuth.currentUser == null) {
      return Future.value(unit) ;
    }else {
      throw ServerException() ;
    }

  }

  @override
  Future<Unit> login(String userName, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: userName, password: password);
    if (firebaseAuth.currentUser != null) {
      debugPrint('login Datasource');
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUser() async {
    var data ;
    var snapshot =  firestore.collection('users');
    await snapshot.where("uid" , isEqualTo :  firebaseAuth.currentUser!.uid.toString()).get().then((value){
      data = value.docs.first.data() ;
    }).onError((error, stackTrace) {
      throw ServerException();
    });

    return UserModel.fromJson(data) ;
  }
}

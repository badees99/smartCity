import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smartcity/features/operating/domain/entities/bin.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/event.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/state.dart';
import 'package:smartcity/features/operating/presentation/pages/operation_screen.dart';
import 'package:smartcity/features/operating/presentation/widgets/costum_dialog.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LocationData? currentLocation;
  Location location = Location.instance;
  bool _isDialogOnTop = false;
  bool _isOpOn = false ;
  List<Bin> routeBinsAll = [];
  BitmapDescriptor markerIcon  = BitmapDescriptor.defaultMarker ;
  BitmapDescriptor binIcon  = BitmapDescriptor.defaultMarker ;
  GoogleMapController? mapController;

  void distanceBetweent(Bin bin) async {
    final diatanceInmeteres = Geolocator.distanceBetween(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        double.parse(bin.latitude),
        double.parse(bin.longitude));
    if (diatanceInmeteres <= 15) {
      var id =  await Navigator.push(context, MaterialPageRoute(builder: (context){
        _isOpOn = true;
        return OperationPage(bin: bin);
      }));
      routeBinsAll.forEach((element) {
        if(element.id == id){
          routeBinsAll.remove(element);
          _isOpOn = false ;
        }
      });

    }
  }
  Future<Uint8List> userMarkerIcon(String path , int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
   markerIcon  = await  BitmapDescriptor.fromAssetImage(
     ImageConfiguration(
       size:  Size(2.0 ,2)
     )
        , "lib/assets/recycling-truck.png"
    ) ;
  }
  void initMarkerIcons() async {
    markerIcon = BitmapDescriptor.fromBytes(await userMarkerIcon("lib/assets/cargo-truck.png", 100)) ;
    binIcon = BitmapDescriptor.fromBytes(await userMarkerIcon("lib/assets/recycle-bin.png", 100)) ;
  }

  void getLocation() async {
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
    location.onLocationChanged.listen((event) {
      routeBinsAll.forEach((element) {
        if(!_isOpOn){
          distanceBetweent(element);
        }
      });
      if(mounted){
        setState(() {
          currentLocation = event;
        });
      }
    });
  }
  @override
  void initState() {
    initMarkerIcons() ;
    getLocation();
    //getRoute(locations[2], locations[3]);
    BlocProvider.of<RouteHandleBloc>(context).add(DrawRouteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<RouteHandleBloc>(context).add(DrawRouteEvent()),
        child: const Icon(Icons.refresh),
      ),
        appBar: AppBar(
          title: Text('Map Screen'),
        ),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: BlocListener<RouteHandleBloc, RouteHandleState>(
            listenWhen: (previous, current) => previous!= current,
            listener: (context, state) {
              if (state is LoadingRouteState) {
                if (CustomDialog.toggle == true) {
                  Navigator.pop(context);
                  CustomDialog.toggle = !CustomDialog.toggle;
                }
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        icon: const CircularProgressIndicator(),
                        message: "الرجاء الانتظار"));
                CustomDialog.toggle = !CustomDialog.toggle;
              }
              if (state is RouteLoadedState) {

                routeBinsAll = state.route.bins ;
                if (CustomDialog.toggle == true) {
                  Navigator.pop(context);
                  CustomDialog.toggle = !CustomDialog.toggle;
                }
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        message: "لقد تم تحميل المسار بنجاح "));
                CustomDialog.toggle = !CustomDialog.toggle;
              }
              if (state is RouteErrorLoadingState) {
                if (CustomDialog.toggle == true) {
                  Navigator.pop(context);
                  CustomDialog.toggle = !CustomDialog.toggle;
                }
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        icon: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        message:
                            "حدث خطا في النظام يرجى اعادة المحاولة لاحقا "));
                CustomDialog.toggle = !CustomDialog.toggle;
              }
              if(state is EmtypRouteState){
                if (CustomDialog.toggle == true) {
                  Navigator.pop(context);
                  CustomDialog.toggle = !CustomDialog.toggle;
                }
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        icon: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        message:
                        "ليس هناك اي حاويات الان \n اعد المحاولة فيما بعد"));
                CustomDialog.toggle = !CustomDialog.toggle;
              }
            },
            child: BlocBuilder<RouteHandleBloc, RouteHandleState>(

              builder: (context, state) {
                if (state is RouteLoadedState) {
                  return (currentLocation != null)
                      ? GoogleMap(
                          minMaxZoomPreference: MinMaxZoomPreference(10, 20),
                          polylines: {
                            Polyline(
                                visible: true,
                                polylineId: PolylineId("routeA"),
                                points: getPolylineCordinates(
                                    state.route.polylines),
                                color: Colors.green,
                                width: 3)
                          },
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          markers: {
                            Marker(
                              rotation: currentLocation!.heading!,
                                markerId: MarkerId("User"),
                                position: LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                                icon: markerIcon
                            ),
                            ...state.route.bins
                                .map((e) => Marker(
                              icon: binIcon,
                                    infoWindow: InfoWindow(),
                                    markerId: MarkerId(e.id.toString()),
                                    position: LatLng(double.parse(e.latitude),
                                        double.parse(e.longitude))))
                                .toSet(),
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!),
                            zoom: 15,
                          ),
                          onCameraMove: (CameraPosition position) {
                            mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(position)
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }
                return currentLocation != null
                    ? GoogleMap(
                        onMapCreated: (controller) {},
                        markers: {
                          Marker(
                            icon: markerIcon,
                              markerId: MarkerId('UserLocation'),
                              position: LatLng(currentLocation!.latitude!,
                                  currentLocation!.longitude!))
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 14.4746,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ));
  }

  List<LatLng> getPolylineCordinates(String polylines) {
    List<LatLng> cordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    polylinePoints.decodePolyline(polylines).forEach((element) =>
        cordinates.add(LatLng(element.latitude, element.longitude)));

    return cordinates;
  }

  void _showDialog(BuildContext context, IconData icon, [String message = '']) {
    _isDialogOnTop = !_isDialogOnTop;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 48.sp,
                ),
                Text(

                  textAlign: TextAlign.right,
                  message,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _isDialogOnTop = !_isDialogOnTop;
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}

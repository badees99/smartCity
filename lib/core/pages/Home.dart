import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:smartcity/features/login/domain/entities/user.dart%20';
import 'package:smartcity/features/login/presentation/bloc/bloc.dart';
import 'package:smartcity/features/login/presentation/bloc/event.dart';
import 'package:smartcity/features/login/presentation/bloc/state.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/event.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/event.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/state.dart';
import 'package:smartcity/features/operating/presentation/manager/state.dart';
import 'package:smartcity/features/operating/presentation/widgets/costum_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool opacityCheck = false;
  bool _isDialogOnTop = false;
  GoogleMapController? mapController ;

  Location location = Location.instance;
  LocationData? currentLocation;

  @override
  void initState() {
    BlocProvider.of<Login_userBloc>(context).add(LoginEvent(userName: 'admin@admin.com', password: '123456789'));
    BlocProvider.of<Login_userBloc>(context).add(GetUserEvent());
    BlocProvider.of<OperatingBloc>(context).add(GetPlanEvent());
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Container container = Container(
    width: 150,
    height: 150,
    color: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("AppMaking.co"),
                accountEmail: Text("sundar@appmaking.co"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/appstore.png'),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/appstore.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.account_box),
                title: const Text("About"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.grid_3x3_outlined),
                title: const Text("Products"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("LogOut"),
                onTap: () {
                  BlocProvider.of<Login_userBloc>(context).add(LogoutEvent());
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              opacityCheck = !opacityCheck;
            });
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.arrow_forward),
        ),
        body: Builder(builder: (context) {
          return CustomScrollView(
            physics: MediaQuery.of(context).orientation == Orientation.landscape
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar.large(
                flexibleSpace: Container(
                  color: const Color(0xff87c885),
                  height: 30.h,
                ),
                floating: true,
                backgroundColor: const Color(0xff87c885),
                leading: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
                expandedHeight: 30.h,
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<Login_userBloc, Login_userState>(
                            builder: (context, state) {
                              if (state is UserDataLoadedState) {
                                return showEmployeeCard(state.user);
                              } else {
                                return showEmployeeCard(User(
                                    id: 'id',
                                    name: 'jj',
                                    eMail: 'eMail',
                                    password: 'password',
                                    job: 'job'));
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 24.h)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: showContainers(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  Container showEmployeeCard(User user) => opacityCheck
      ? Container(
          width: 1.sw - 5.w,
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            clipBehavior: Clip.antiAlias,
            elevation: 10.0,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'planpage/');
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text('${user.name}'),
                      leading: const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/6/6b/Nizar_Rawi_Personal_Photo.jpg'),
                      ),
                    ),
                    const Divider(),
                    BlocBuilder<OperatingBloc, OperatingState>(
                      builder: (context, state) {
                        if (state is LoadingOperatingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SuccessPlanLoad) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Table(
                                children: <TableRow>[
                                  TableRow(children: [
                                    Text('Plan id'),
                                    Text(state.planModel.id),
                                  ]),
                                  TableRow(children: [
                                    Text('Plan date'),
                                    Text(state.planModel.timeStamp
                                        .toDate()
                                        .toString()),
                                  ]),
                                  TableRow(children: [
                                    Text('Plan Site'),
                                    Text(state.planModel.siteId),
                                  ]),
                                ],
                              ));
                        } else {
                          return Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Center(
                                child: Text('You have no plans today !!'),
                              ));
                        }
                      },
                    ),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ),
          ),
        )
      : Container();

  List<Widget> showContainers(context) {
    if (opacityCheck) {
      return [
        conta(context, 'Collection', Icons.delete_outline),
        conta(context, 'Maintance', Icons.settings)
      ];
    } else {
      return [
        Container(),
      ];
    }
  }
  List<LatLng> getPolylineCordinates(String polylines) {
    List<LatLng> cordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    polylinePoints.decodePolyline(polylines).forEach((element) =>
        cordinates.add(LatLng(element.latitude, element.longitude)));

    return cordinates;
  }

  InkWell conta(context, String title, IconData icon) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, '${title.toLowerCase()}/').then((value) {
            initState();
          });
        },
        child: Container(
          width: 150.w,
          height: 130.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: const Color(0xff87c885),
          ),
          child: RPadding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 38.h,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: title.substring(0, 3),
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 24.sp,
                        color: const Color(0xffecffe2),
                      )),
                  TextSpan(
                    text: title.substring(3, title.length),
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: const Color(0xffecffe2),
                    ),
                  ),
                ])),
                RPadding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: const Color(0xffecffe2),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void _showBottomSheet(BuildContext context, IconData icon, [message]) {
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

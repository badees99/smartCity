import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcity/core/pages/Home.dart';
import 'package:smartcity/core/pages/themap.dart';
import 'package:smartcity/features/login/presentation/bloc/state.dart';
import 'package:smartcity/features/login/presentation/pages/login_page.dart';
import 'package:smartcity/features/operating/presentation/manager/bloc.dart';
import 'package:smartcity/features/operating/presentation/manager/routehandle/bloc.dart';
import 'package:smartcity/features/operating/presentation/pages/CollectionPage.dart';
import 'package:smartcity/features/operating/presentation/pages/maintance.dart';
import 'package:smartcity/features/operating/presentation/pages/planpage.dart';
import 'package:smartcity/firebase_options.dart';
import 'package:smartcity/features/login/presentation/bloc/bloc.dart';
import 'package:smartcity/inection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(SmartCity());
}

class SmartCity extends StatelessWidget {
  const SmartCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<Login_userBloc>()),
          BlocProvider(create: (_) => di.sl<OperatingBloc>()) ,
          BlocProvider(create: (_)=> di.sl<RouteHandleBloc>()) ,
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                theme: ThemeData(
                    primaryColor: const Color(0xff57c885),
                    backgroundColor: const Color(0xffecffe2)),
                routes: {
                  'home/': (context) => const Home(),
                  'collection/': (context) => const Collection(),
                  'login/': (context) => const LoginPage(),
                  'planpage/': (context) => const PlanPage(),
                  'maintance/':(context) => const Maintance(),
                  'mapscreen/':(context) =>  const MapScreen(),
                },
                debugShowCheckedModeBanner: false,
                home: child);
          },
          child:
          BlocBuilder<Login_userBloc, Login_userState>(
            buildWhen:  (previous, current) => current!=previous,
            builder: (context, state) {
              if (state is LoadingLoginState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedLoginState ||
                  state is UserDataLoadedState ||state is ErrorGetUserDataState) {
                return const Home();
              }  else {
                return const LoginPage();
              }
            },
          ),
        ));
  }
}

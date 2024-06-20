import 'package:aqua_sense_mobile/config/routes.dart';
import 'package:aqua_sense_mobile/cubit/sign_in_cubit.dart';
import 'package:aqua_sense_mobile/page/dashboard_page.dart';
import 'package:aqua_sense_mobile/page/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Aquasense",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.login,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case Routes.login:
              return CupertinoPageRoute(
                builder: (context) => BlocProvider<SignInCubit>(
                  create: (context) => SignInCubit(),
                  child: const LoginPage(),
                ),
              );
            case Routes.dashboard:
              return CupertinoPageRoute(
                builder: (context) => const DashboardPage(),
              );

            default:
              return CupertinoPageRoute(
                builder: (context) => const DashboardPage(),
              );
          }
        },
      ),
    );
  }
}

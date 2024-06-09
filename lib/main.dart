import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/Internet/DioHelper.dart';
import 'package:shop/Screens/Shop Main Page.dart';
import 'package:shop/Screens/loginPage.dart';
import 'package:shop/Screens/onBoarding.dart';
import 'package:shop/Shared/CacheHelper.dart';
import 'BloCs and Cubits/BlocObserver/Bloc Observer.dart';
import 'Shared/Constants.dart';

Widget FirstWidget() {

  if (cacheHelper.getData(key: "onBoarding")!=true) {
    return onBoardingScreen();
  }
  else {
    if (cacheHelper.getData(key: "token")!=null) {
      return ShopScreen();
    }
    else {
      return loginScreen();
    }

  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await cacheHelper.init();
  dioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstWidget(),
      theme: ThemeData(
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0
        ),
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              )),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "MainFont",
                color: Colors.black),
            bodyMedium: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "MainFont",
                color: Colors.black),
            bodySmall: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "MainFont",
                color: Colors.black),
          ),
          primarySwatch: Colors.pink),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weatherapp1/Userdetailsprovider.dart';
import 'package:weatherapp1/favouritecityprovider.dart';
import 'package:weatherapp1/pages/AddCities.dart';
import 'package:weatherapp1/pages/landingpage.dart';
import 'package:weatherapp1/weatherprovider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteCitiesProvider()),
    ChangeNotifierProvider<WeatherProvider>(
    create: (context) => WeatherProvider(),
    ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? AddCities() : LandingPage(),
      ),
    );
  }
}

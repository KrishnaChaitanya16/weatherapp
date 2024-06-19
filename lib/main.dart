import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        home: SplashScreen(
          isLoggedIn: isLoggedIn,
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;

  SplashScreen({required this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget.isLoggedIn ? AddCities() : LandingPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 13, 51, 1), // Customize the background color of your splash screen
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: SizedBox(height:270,child: Image.asset('assets/opening.png',fit: BoxFit.cover,)), // Replace with your logo or desired widget
              ),
            ),
            SizedBox(height: 10,),
            FadeTransition(opacity: _animation,
            child: Text('Daily Weather App',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weatherapp1/pages/details.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 12, 51, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/opening.png', height: 270,),
            SizedBox(height: 10),
            Text('Daily Weather App', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Get to know Weather", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
            Text('Of Your Location', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300,),),
            SizedBox(height: 70,),
            SizedBox(
              width: 200, // Increase the width of the button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage()), // Navigate to YourDetailsPage
                  );
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change the button color to blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

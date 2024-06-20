import 'package:flutter/material.dart';
import 'package:weatherapp1/pages/details.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 12, 51, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/opening.png', height: 270,),
            const SizedBox(height: 10),
            const Text('Daily Weather App', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text("Get to know Weather", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
            const Text('Of Your Location', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300,),),
            const SizedBox(height: 70,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
              ),
              child: const Text("Get Started", style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}

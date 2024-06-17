import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp1/pages/AddCities.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String selectedCountry = 'India'; // Default country selection

  // List of countries for dropdown
  List<String> countries = ['India', 'USA', 'UK', 'Canada', 'Australia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 12, 51, 1),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Your Details",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 33),),
            SizedBox(height: 10,),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email ID',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cityController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'City',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                });
              },
              items: countries.map<DropdownMenuItem<String>>((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Country',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Outline color
                ),
              ),
              dropdownColor: Color.fromRGBO(8, 12, 51, 1), // Dropdown background color
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveDetails();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addcities()),
                );
              },
              child: Text('Submit',style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to save details using SharedPreferences
  void saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('country', selectedCountry);

    // Get current favorite cities list from SharedPreferences
    List<String>? favoriteCities = prefs.getStringList('favoriteCities') ?? [];
    // Add the current city to the favorite cities list if not already present
    String cityCountry = '${cityController.text}, ${selectedCountry}';
    if (!favoriteCities.contains(cityCountry)) {
      favoriteCities.add(cityCountry);
      await prefs.setStringList('favoriteCities', favoriteCities);
    }
  }
}

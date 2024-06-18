import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp1/Userdetailsprovider.dart';
import 'package:weatherapp1/pages/AddCities.dart';

class DetailsPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String selectedCountry = 'India'; // Default country selection

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 12, 51, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your Details",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 33),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.name = value,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.email = value,
              decoration: InputDecoration(
                labelText: 'Email ID',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: cityController,
              style: TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.city = value,
              decoration: InputDecoration(
                labelText: 'City',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity, // Make the container take up full width

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(8, 12, 51, 1), // Match background color
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCountry, // Pre-selected value
                dropdownColor: Color.fromRGBO(8, 12, 51, 1), // Match background color
                iconEnabledColor: Colors.white, // White dropdown icon
                iconDisabledColor: Colors.white, // White disabled dropdown icon
                iconSize: 24.0, // Adjust icon size as desired
                onChanged: (value) {
                  selectedCountry = value!;
                  userDetailsProvider.country = value;
                },
                items: ['India', 'USA', 'UK', 'Canada', 'Australia','Japan','China']
                    .map<DropdownMenuItem<String>>((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Country',
                  labelStyle: TextStyle(color: Colors.white), // White label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // White border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // White border
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform validation
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    cityController.text.isNotEmpty) {
                  // Save details to provider
                  userDetailsProvider.name = nameController.text;
                  userDetailsProvider.email = emailController.text;
                  userDetailsProvider.city = cityController.text;
                  userDetailsProvider.country = selectedCountry;

                  // Navigate to AddCities page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCities()));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Validation Error'),
                      content: Text('Please fill in all fields.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Submit', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

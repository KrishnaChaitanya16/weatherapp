import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp1/Userdetailsprovider.dart';
import 'package:weatherapp1/pages/AddCities.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  late final String selectedCountry; // Declare as late final

  @override
  void initState() {
    super.initState();
    selectedCountry = 'India'; // Initialize selectedCountry
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 12, 51, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Your Details",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 33),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.name = value,
              decoration: const InputDecoration(
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
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.email = value,
              decoration: const InputDecoration(
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
            const SizedBox(height: 20),
            TextFormField(
              controller: cityController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => userDetailsProvider.city = value,
              decoration: const InputDecoration(
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
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(8, 12, 51, 1),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCountry,
                dropdownColor: const Color.fromRGBO(8, 12, 51, 1),
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                iconSize: 24.0,
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value!;
                    userDetailsProvider.country = value;
                  });
                },
                items: ['India', 'USA', 'UK', 'Canada', 'Australia', 'Japan', 'China']
                    .map<DropdownMenuItem<String>>((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: 'Country',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    cityController.text.isNotEmpty) {
                  userDetailsProvider.name = nameController.text;
                  userDetailsProvider.email = emailController.text;
                  userDetailsProvider.city = cityController.text;
                  userDetailsProvider.country = selectedCountry;

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', true);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddCities()));
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Validation Error'),
                      content: const Text('Please fill in all fields.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

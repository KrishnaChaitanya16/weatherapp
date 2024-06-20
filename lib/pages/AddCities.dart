import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp1/favouritecityprovider.dart';
import 'package:weatherapp1/pages/LandingPage.dart';
import 'weatherpage.dart';

class AddCities extends StatelessWidget {
  const AddCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 12, 51, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () async {
                      final favoriteCitiesProvider = Provider.of<FavoriteCitiesProvider>(context, listen: false);
                      favoriteCitiesProvider.clearCities(); // Clear favorite cities

                      // Set isLoggedIn to false
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);

                      // Navigate to the landing page
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()),
                            (route) => false, // Remove all routes except landing page
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 220,),
              const Text(
                "Add Cities",
                style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const AddCityForm(),
              const SizedBox(height: 20),
              const Expanded(
                child: FavoriteCitiesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCityForm extends StatefulWidget {
  const AddCityForm({super.key});

  @override
  _AddCityFormState createState() => _AddCityFormState();
}

class _AddCityFormState extends State<AddCityForm> {
  TextEditingController cityController = TextEditingController();
  String selectedCountry = 'India'; // Default country selection

  // List of countries for dropdown
  List<String> countries = ['India', 'USA', 'UK', 'Canada', 'Australia', 'Japan', 'China'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: cityController,
            style: const TextStyle(color: Colors.white),
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
          DropdownButtonFormField<String>(
            value: selectedCountry, // Pre-selected value
            dropdownColor: const Color.fromRGBO(8, 12, 51, 1), // Match background color
            iconEnabledColor: Colors.white, // White dropdown icon
            iconDisabledColor: Colors.white, // White disabled dropdown icon
            iconSize: 24.0, // Adjust icon size as desired
            onChanged: (value) {
              setState(() { // Assuming you're using a StatefulWidget
                selectedCountry = value!;
              });
            },
            items: countries.map<DropdownMenuItem<String>>((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(
                  country,
                  style: const TextStyle(color: Colors.white), // White text
                ),
              );
            }).toList(),
            decoration: const InputDecoration(
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final favoriteCitiesProvider = Provider.of<FavoriteCitiesProvider>(context, listen: false);
              favoriteCitiesProvider.addCity(cityController.text.trim(), selectedCountry);
              cityController.clear(); // Clear input after adding city
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
            ),
            child: const Text('Add City', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class FavoriteCitiesList extends StatelessWidget {
  const FavoriteCitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCitiesProvider = Provider.of<FavoriteCitiesProvider>(context);

    return ListView.builder(
      itemCount: favoriteCitiesProvider.favoriteCities.length,
      itemBuilder: (context, index) {
        String cityCountry = favoriteCitiesProvider.favoriteCities[index];
        String city = cityCountry.split(',')[0].trim();
        String country = cityCountry.split(',')[1].trim();
        return Dismissible(
          key: Key(cityCountry),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            favoriteCitiesProvider.removeCity(cityCountry);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$cityCountry is removed from Favourites")));
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(34, 35, 79, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(cityCountry, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherPage(cityName: city, countryName: country),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weatherapp1/favouritecityprovider.dart';
import 'package:weatherapp1/weatherprovider.dart';

class WeatherPage extends StatelessWidget {
  final String cityName;
  final String countryName;

  const WeatherPage({super.key, required this.cityName, required this.countryName});

  String getWeatherImage(String weatherMain, String icon) {
    String timeOfDay = icon.endsWith('d') ? 'day' : 'night';

    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return timeOfDay == 'day' ? 'assets/sunnyday.png' : 'assets/moon.png';
      case 'rain':
        return timeOfDay == 'day'? 'assets/raining.jpg' : 'assets/rainynight.jpg' ;
      case 'clouds':
        return timeOfDay == 'day' ? 'assets/cloudyday.jpg' : 'assets/cloudynight.png';
      case 'snow':
        return 'assets/snow.jpg';
      case 'thunderstorm':
        return 'assets/thunderstorm.jpg';
      case 'haze':
        return 'assets/haze.png';
      case 'drizzle':
        return 'assets/raining.jpg';
      case 'mist':
        return timeOfDay=='day'?'assets/Mist.png':'assets/nightmist.png';
      default:
        return 'assets/opening.png'; // A default image for unspecified conditions
    }
  }

  Future<void> _refreshWeatherData(BuildContext context, String city, String country) async {
    await Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData(city, country);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCitiesProvider = Provider.of<FavoriteCitiesProvider>(context);
    final pageController = PageController();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 12, 51, 1),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: favoriteCitiesProvider.favoriteCities.length,
              itemBuilder: (context, index) {
                final cityCountry = favoriteCitiesProvider.favoriteCities[index];
                final city = cityCountry.split(',')[0].trim();
                final country = cityCountry.split(',')[1].trim();

                return RefreshIndicator(
                  color: Colors.purple,
                  onRefresh: () => _refreshWeatherData(context, city, country),
                  child: FutureBuilder(
                    future: Provider.of<WeatherProvider>(context, listen: false).fetchWeatherData(city, country),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
                      } else {
                        final weatherProvider = Provider.of<WeatherProvider>(context);
                        var weatherInfo = weatherProvider.weatherData;
                        var mainInfo = weatherInfo['main'];
                        var weather = weatherInfo['weather'][0];

                        return ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on_outlined, color: Colors.white),
                                    const SizedBox(width: 5,),
                                    Text(
                                      "${weatherInfo['name']}, ${weatherInfo['sys']['country']}",
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50), // Add some space at the top
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 300,
                                  height: 280,
                                  child: Image.asset(
                                    getWeatherImage(weather['main'], weather['icon']),
                                    width: 100, // Adjust size as needed
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${weather['main']}',
                                  style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '${(mainInfo['temp'] - 273.15).toStringAsFixed(1)} °C',
                                  style: const TextStyle(fontSize: 70, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 250,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color.fromRGBO(44, 46, 77, 1),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(left: 35, child: SizedBox(height: 75, child: Image.asset("assets/humidity1.png", fit: BoxFit.cover))),
                                            const Positioned(top: 80, left: 18,
                                              child: Text(
                                                'Humidity:',
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Positioned(left: 38, top: 145, child: Text("${mainInfo['humidity']}%", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 250,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color.fromRGBO(44, 46, 77, 1),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(left: 25, child: SizedBox(height: 80, width: 80, child: Image.asset('assets/feelslike-removebg-preview.png', fit: BoxFit.cover))),
                                            const Positioned(top: 82, left: 10,
                                              child: Text(
                                                'Feels Like:',
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Positioned(top: 145, left: 27, child: Text('${(mainInfo['feels_like'] - 273.15).toStringAsFixed(1)} °C', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 29))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 250,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color.fromRGBO(44, 46, 77, 1),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(left: 20, child: SizedBox(height: 85, child: Image.asset('assets/windspeed.png', fit: BoxFit.cover))),
                                            const Positioned(top: 82, left: 8,
                                              child: Text(
                                                'Wind Speed:',
                                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Positioned(top: 145, left: 15, child: Text('${weatherInfo['wind']['speed']} m/s', style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: favoriteCitiesProvider.favoriteCities.length,
            effect: WormEffect(
              dotHeight: 8.0,
              dotWidth: 8.0,
              activeDotColor: Colors.white,
              dotColor: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

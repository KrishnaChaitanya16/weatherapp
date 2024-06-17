import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp1/weatherprovider.dart';


class WeatherPage extends StatefulWidget {
  final String cityName;
  final String countryName;

  WeatherPage({required this.cityName, required this.countryName});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<void> _refreshWeatherData() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .fetchWeatherData(widget.cityName, widget.countryName);
  }

  String getWeatherImage(String weatherMain, String icon) {
    String timeOfDay = icon.endsWith('d') ? 'day' : 'night';

    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return timeOfDay == 'day' ? 'assets/sunnyday.png' : 'assets/moon.png';
      case 'rain':
        return 'assets/raining.jpg';
      case 'clouds':
        return timeOfDay == 'day' ? 'assets/cloudyday.jpg' : 'assets/cloudynight.jpg';
      case 'snow':
        return 'assets/snowy.png';
      case 'thunderstorm':
        return 'assets/thunderstorm.jpg';
      case 'haze':
        return 'assets/haze.png';
      case 'drizzle':
        return 'assets/raining.jpg';
      default:
        return 'assets/default.png'; // A default image for unspecified conditions
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 12, 51, 1),
      body: RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: Center(
          child: FutureBuilder(
            future: weatherProvider.fetchWeatherData(widget.cityName, widget.countryName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                final weatherInfo = weatherProvider.weatherData;
                final mainInfo = weatherInfo['main'];
                final weather = weatherInfo['weather'][0];

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "${weatherInfo['name']}, ${weatherInfo['sys']['country']}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 300,
                      height: 280,
                      child: Image.asset(
                        getWeatherImage(weather['main'], weather['icon']),
                        width: 100,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${weather['main']}',
                      style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${(mainInfo['temp'] - 273.15).toStringAsFixed(1)} °C',
                      style: TextStyle(fontSize: 70, color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 250,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(44, 46, 77, 1),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 35,
                                  child: SizedBox(
                                    height: 75,
                                    child: Image.asset(
                                      "assets/humidity1.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  left: 18,
                                  child: Text(
                                    'Humidity:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  left: 38,
                                  top: 145,
                                  child: Text(
                                    "${mainInfo['humidity']}%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 250,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(44, 46, 77, 1),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 25,
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                      'assets/feelslike-removebg-preview.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 82,
                                  left: 10,
                                  child: Text(
                                    'Feels Like:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 145,
                                  left: 27,
                                  child: Text(
                                    '${(mainInfo['feels_like'] - 273.15).toStringAsFixed(1)} °C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 29),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 250,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(44, 46, 77, 1),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  child: SizedBox(
                                    height: 85,
                                    child: Image.asset(
                                      'assets/windspeed.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 82,
                                  left: 8,
                                  child: Text(
                                    'Wind Speed:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  top: 145,
                                  left: 15,
                                  child: Text(
                                    '${weatherInfo['wind']['speed']} m/s',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 29),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON data
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic> _weatherData = {};

  Map<String, dynamic> get weatherData => _weatherData;

  Future<void> fetchWeatherData(String cityName, String countryName) async {
    final apiKey = '7300b352f328faaea52ba10089a867ed'; // Replace with your actual API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName,$countryName&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _weatherData = json.decode(response.body);
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw error;
    }
  }
}

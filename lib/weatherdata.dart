class WeatherData {
  final String city;
  final double temperature;

  WeatherData({required this.city, required this.temperature});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}

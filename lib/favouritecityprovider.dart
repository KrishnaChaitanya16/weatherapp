import 'package:flutter/foundation.dart';

class FavoriteCitiesProvider with ChangeNotifier {
  final List<String> _favoriteCities = [];

  List<String> get favoriteCities => _favoriteCities;

  void addCity(String city, String country) {
    _favoriteCities.add('$city, $country');
    notifyListeners();
  }
  void removeCity(String cityCountry) {
    _favoriteCities.remove(cityCountry);
    notifyListeners();
  }
}

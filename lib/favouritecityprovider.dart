import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCitiesProvider with ChangeNotifier {
  List<String> _favoriteCities = [];

  List<String> get favoriteCities => _favoriteCities;

  FavoriteCitiesProvider() {
    _loadFavoriteCities();
  }

  Future<void> _loadFavoriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteCities = prefs.getStringList('favoriteCities') ?? [];
    notifyListeners();
  }

  Future<void> addCity(String city, String country) async {
    String cityCountry = '$city, $country';
    if (!_favoriteCities.contains(cityCountry)) {
      _favoriteCities.add(cityCountry);
      await _saveFavoriteCities();
    }
  }

  Future<void> removeCity(String cityCountry) async {
    _favoriteCities.remove(cityCountry);
    await _saveFavoriteCities();
  }

  Future<void> clearCities() async {
    _favoriteCities.clear();
    await _saveFavoriteCities();
  }

  Future<void> _saveFavoriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteCities', _favoriteCities);
    notifyListeners();
  }
}

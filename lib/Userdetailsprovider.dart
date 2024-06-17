import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  late String _name;
  late String _email;
  late String _city;
  late String _country;

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get city => _city;
  set city(String value) {
    _city = value;
    notifyListeners();
  }

  String get country => _country;
  set country(String value) {
    _country = value;
    notifyListeners();
  }

  void saveUserDetails(String name, String email, String city, String country) {
    _name = name;
    _email = email;
    _city = city;
    _country = country;
    notifyListeners();
  }
}

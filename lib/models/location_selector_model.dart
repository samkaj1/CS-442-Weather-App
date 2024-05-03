import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSelectorModel with ChangeNotifier {
  List<String> _locationSelector = [];

  List<String> get locationSelector => _locationSelector;

  LocationSelectorModel() {
    loadLocations();
  }

  Future<void> loadLocations() async { //load locations
    try {
      final prefs = await SharedPreferences.getInstance();
      final locations = prefs.getStringList('locations');

      if (locations != null) {
        _locationSelector = locations;
      }

      notifyListeners();
    } catch (e) {
      print('Error loading your requested location: $e'); //Error Handler
    }
  }

  Future<void> addLocation(String location) async { //add a location
    if(!_locationSelector.contains(location) && location.isNotEmpty) {
      _locationSelector.add(location);
      await _saveLocations();
      notifyListeners();
    }
  }

  Future<void> deleteLocation(String location) async { //remove a location
    if (_locationSelector.remove(location)) {
      await _saveLocations();
      notifyListeners();
    }
  }

  Future<void> _saveLocations() async { //save locations
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('locations', _locationSelector);
    } catch (e) {
      print('Error saving your requested location: $e'); //Error Handler
    }
  }
}
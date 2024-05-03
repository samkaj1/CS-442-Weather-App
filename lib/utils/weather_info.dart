import 'package:mp5/models/weather_info_model.dart';
import 'package:flutter/foundation.dart';

class WeatherInfoProvider with ChangeNotifier { //provider for weather information
  List<Weather> _weatherInfo = [];

  List<Weather> get weatherInfo => _weatherInfo;

  void updateWeatherInfo(List<Weather> newWeatherInfo) {
    if (newWeatherInfo.isNotEmpty) {
      _weatherInfo = newWeatherInfo;
      notifyListeners();
    }
  }
}
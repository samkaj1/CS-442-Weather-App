import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:mp5/models/weather_info_model.dart';

class WeatherInfoView extends StatefulWidget {
  final Weather weather;

  const WeatherInfoView({
    super.key,
    required this.weather
  });

  @override
  WeatherInfoViewState createState() => WeatherInfoViewState();
}

class WeatherInfoViewState extends State<WeatherInfoView> {
  String _unit = "Imperial";

  @override
  void initState() {
    super.initState();
    _loadSystemPref();
  }

  Future<void> _loadSystemPref() async { //loads system pref
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _unit = prefs.getString('unit') ?? 'Imperial';
    });
  }

  String _convertedTemperature(double temp) { //conversion
    if (_unit == 'Metric') {
      return '${(temp - 273.15).toStringAsFixed(1)}°C';
    } else {
      return '${(temp * 9 / 5 - 459.67).toStringAsFixed(1)}°F';
    }
  }

  @override
  Widget build(BuildContext context) { //adding each aspect of the weather info
    return Scaffold(
      body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/background_image.jpg',
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: <Widget>[
              Text(
                widget.weather.locationName, //name
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                'Temperature: ${_convertedTemperature(widget.weather.temperature)}', //temp
                style: const TextStyle(fontSize: 30)
              ),
              Text (
                'Feels-Like: ${_convertedTemperature(widget.weather.feelsLikeTemp)}', //feels-like temp
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                widget.weather.description, //description
                style: const TextStyle(fontSize: 25),
              ),
              Image.network(
                'http://openweathermap.org/img/w/${widget.weather.icon}.png', //icon
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}


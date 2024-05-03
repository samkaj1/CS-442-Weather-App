import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiInfo { //api info
  final String apiKey = "ac2e918f1ce2101a3d687563fda37532";
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<dynamic> getLocationWeather(String location) async { //gets weather info data based on given location
    final response = await http.get(Uri.parse('$baseUrl?q=$location&appid=$apiKey'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body); //returns json data
    } else {
      throw Exception('Failed to load weather information');
    }
  }
}
class Weather {
  final String locationName;
  final double temperature;
  final double feelsLikeTemp;
  final String description;
  final String? icon;


  Weather( {
    required this.locationName,
    required this.temperature,
    required this.feelsLikeTemp,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) { //convert from JSON from api to information used in my app
    try {
      return Weather(
        locationName: json['name'] as String,
        temperature: (json['main']['temp'] as num).toDouble(),
        feelsLikeTemp: (json['main']['feels_like'] as num).toDouble(),
        description: json['weather'][0]['description'] as String,
        icon: json['weather'][0]['icon'] as String,
      );
    } catch (e) {
      print('Error parsing JSON data: $e');
      rethrow;
    }
  }
}
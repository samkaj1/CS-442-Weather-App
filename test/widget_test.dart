// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mp5/models/weather_info_model.dart';
import 'package:mp5/utils/weather_info.dart';
import 'package:mp5/views/view_weather_info.dart';

class MockWeatherService extends Mock implements WeatherInfoProvider {
  getLocationWeather(any) {}
}

void main() {
  group('WeatherApp Tests', () {
    late MockWeatherService mockWeatherService;

    setUp(() {
      mockWeatherService = MockWeatherService();
    });

     testWidgets('Display Weather Info', (WidgetTester tester) async {
      // Define a Weather object
      final weather = Weather(
        locationName: 'Cupertino',
        temperature: 22,
        feelsLikeTemp: 23,
        icon: 'icon_url',
        description: 'Sunny',
      );

    testWidgets('Fetches weather data and updates UI', (WidgetTester tester) async {
      // Mock the behavior of the getWeather method
      when(mockWeatherService.getLocationWeather(any)).thenAnswer(
            (_) async => {
          'city': 'Cupertino',
          'temperature': 22,
          'weatherIconUrl': 'icon_url',
          'weatherDescription': 'Sunny'
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: WeatherInfoView(weather: weather)
        ),
      );

      // Verify that the initial state is correct.
      expect(find.text('City:'), findsNothing);
      expect(find.text('Temperature:'), findsNothing);

      // Enter a city and tap the "Get Weather" button
      await tester.enterText(find.byType(TextField), 'Cupertino');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the UI updates with the fetched weather data
      expect(find.text('City: Cupertino'), findsOneWidget);
      expect(find.text('Temperature: 22°C'), findsOneWidget);
      expect(find.text('Condition: Sunny'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
  });
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mp5/views/view_weather_info.dart';
import 'package:mp5/models/location_selector_model.dart';
import 'package:mp5/models/weather_info_model.dart';
import 'package:mp5/utils/weather_info.dart';
import 'package:mp5/utils/api_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late LocationSelectorModel locationSelectorModel;
  int _selectedIndex = 0; //initialize index
  final ApiInfo _apiInfo = ApiInfo();

  @override
  void initState() {
    super.initState();
    locationSelectorModel = Provider.of<LocationSelectorModel>(context, listen: false);
    locationSelectorModel.addListener(_loadWeatherInfo);
    _selectedIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadWeatherInfo());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = Provider.of<LocationSelectorModel>(context, listen: false);
    if (locationSelectorModel != model) {
      locationSelectorModel.removeListener(_loadWeatherInfo);
      locationSelectorModel = model;
      locationSelectorModel.addListener(_loadWeatherInfo);
    }
  }

  @override
  void dispose() {
    locationSelectorModel.removeListener(_loadWeatherInfo);
    super.dispose();
  }

  _loadWeatherInfo() async {
    try {
      final List<Weather> weatherInfoList = [];
      for (final location in locationSelectorModel.locationSelector) {
        final data = await _apiInfo.getLocationWeather(location);
        weatherInfoList.add(Weather.fromJson(data));
      }
      final weatherInfo = Provider.of<WeatherInfoProvider>(context, listen: false);
      weatherInfo.updateWeatherInfo(weatherInfoList);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load weather data: $e'),
          ),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      final weatherInfoProvider = Provider.of<WeatherInfoProvider>(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            weatherInfoProvider.weatherInfo.isEmpty
                ? 'Weather (${weatherInfoProvider.weatherInfo.length})'
                : "Current Weather",
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: _loadWeatherInfo,
            ),
          ],
        ),
        body: weatherInfoProvider.weatherInfo.isNotEmpty ? 
          Column (
            children: <Widget> [
              Expanded(
                child: PageView.builder(
                  itemCount: weatherInfoProvider.weatherInfo.length,
                  onPageChanged: (index) => setState(() => _selectedIndex = index),
                  itemBuilder: (context, index) =>
                    WeatherInfoView(weather: weatherInfoProvider.weatherInfo[index])
                ),
              ),
              _buildPageDots(weatherInfoProvider),
            ],
          )
          : const Center(child: Text('No Locations have been added yet. Please proceed to the Location Selector via the Menu and add your locations!')),
      );
    }

    Widget _buildPageDots(WeatherInfoProvider weatherInfoProvider) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          weatherInfoProvider.weatherInfo.length,
          (index) => Container(
            margin: const EdgeInsets.all(4.0),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedIndex == index ? Colors.black : Colors.black.withOpacity((0.3)),
            ),
          ),
        ),
      );
    }  
}
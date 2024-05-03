import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mp5/utils/weather_info.dart';
import 'package:mp5/models/location_selector_model.dart';

MultiProvider getProviderSetup(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => WeatherInfoProvider()),
      ChangeNotifierProvider(create: (context) => LocationSelectorModel()),
    ],
    child: child,
  );
}
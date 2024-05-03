import 'package:flutter/material.dart';
import 'package:mp5/views/provider_setup.dart';
import 'package:mp5/views/page_setup.dart';


void main() {
  runApp(
    getProviderSetup(
      const MaterialApp(
        title: 'My Weather App',
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
    )
  );
}

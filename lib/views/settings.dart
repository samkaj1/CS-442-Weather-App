import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  String _unit = "Imperial";
  late bool _isDarkMode = false;

  @override
  void initState() { //initialize state
    super.initState();
    _loadSystemPref();
    _loadDarkModePref();
  }

  Future<void> _loadSystemPref() async { // load metric/imperial system
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _unit = prefs.getString("unit") ?? "Imperial";
  });
  }

  Future<void> _saveSystemPref(String unit) async { //save metric/imperial system
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unit', unit);
    setState(() {
      _unit = unit;
    });
  }

  Future<void> _loadDarkModePref() async { //load dark mode
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool("darkMode") ?? false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async { //dark mode toggle
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) { //setting of changing metric/imperial system
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temperature System',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _unit,
          items: <String>['Metric', 'Imperial']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>( //dropdown for selection
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _saveSystemPref(newValue);
            }
          },
            ),
            const SizedBox(height: 20),
            const Text(
              'Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), //add dark mode toggle setting
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            )
          ],
        ),
      ),
    );
  }
}

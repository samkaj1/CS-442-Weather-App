import 'package:flutter/material.dart';
import 'package:mp5/views/home.dart';
import 'package:mp5/views/location_selector.dart';
import 'package:mp5/views/settings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "My Weather App",
      home: DefaultPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  DefaultPageState createState() => DefaultPageState();
}

class DefaultPageState extends State<DefaultPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    Home(),
    LocationPage(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) { //drawer for options
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Weather App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),
            _buildDrawerItem(Icons.home, 'Home', 0),
            _buildDrawerItem(Icons.location_pin, 'Location Selector', 1),
            _buildDrawerItem(Icons.settings, 'Settings', 2),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildDrawerHeader() { 
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          'Your Menu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
         ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        setState(() {
          _selectedIndex = index;
          Navigator.pop(context);
        });
      },
    );
  }
}
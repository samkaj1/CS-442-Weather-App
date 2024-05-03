import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mp5/models/location_selector_model.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {

  void _addLocation(BuildContext context, String location) { //add location
    final locationSelectorModel = Provider.of<LocationSelectorModel>(context, listen: false);
    if (!locationSelectorModel.locationSelector.contains(location) && location.isNotEmpty) {
      locationSelectorModel.addLocation(location);
    }
  }

  void _deleteLocation(BuildContext context, String location) { //remove location
    final locationSelectorModel = Provider.of<LocationSelectorModel>(context, listen: false);
    if (locationSelectorModel.locationSelector.contains(location)) {
      locationSelectorModel.deleteLocation(location);
    }
  }

  void _addLocationPopup(BuildContext context) { //adding location popup message
    String newLocation = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add a Location"),
          content: TextField(
            onChanged: (value) {
              newLocation = value;
            },
            decoration: const InputDecoration(hintText: "Location Name"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Add"),
              onPressed: () {
                Navigator.of(context).pop();
                _addLocation(context, newLocation.trim());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationSelectorModel = Provider.of<LocationSelectorModel>(context);
    final locationSelector = locationSelectorModel.locationSelector;

    return Scaffold( //page setup
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Locations'),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_box_rounded),
            onPressed: () => _addLocationPopup(context)
          ),
        ],
      ),
      body: ListView.builder( //delete button
        itemCount: locationSelector.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(locationSelector[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete_forever_rounded),
              onPressed: () => _deleteLocation(context, locationSelector[index]),
            ),
          );
        },
      ),
    );
  }
}
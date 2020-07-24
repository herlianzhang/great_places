import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LatLng _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final loc = await Location().getLocation();
    setState(() {
      _previewImageUrl = LatLng(loc.latitude, loc.longitude);
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) {
        return _previewImageUrl == null
            ? MapScreen()
            : MapScreen(
                initialLocation: PlaceLocation(
                  latitude: _previewImageUrl.latitude,
                  longitude: _previewImageUrl.longitude,
                ),
                isSelecting: true,
              );
      },
    ));

    if (selectedLocation == null) return;
    setState(() {
      _previewImageUrl = selectedLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Center(
                  child: Text(
                    'No Location Chosen',
                    textAlign: TextAlign.center,
                  ),
                )
              : Center(
                  child: Text(
                      'Lat: ${_previewImageUrl.latitude}, Lng: ${_previewImageUrl.longitude}'),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}

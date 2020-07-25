import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final bool isFromDetail;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 0.7893, longitude: 113.9213),
      this.isSelecting = false, this.isFromDetail = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng myLatLng;

  @override
  void initState() {
    super.initState();
    if (widget.isSelecting == true)
      myLatLng = LatLng(
          widget.initialLocation.latitude, widget.initialLocation.longitude);
  }

  void _selectLocation(LatLng latlng) {
    setState(() {
      myLatLng = latlng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          if (!widget.isFromDetail) IconButton(
            icon: Icon(Icons.save),
            onPressed: myLatLng == null ? null : () {
              Navigator.of(context).pop(myLatLng);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: widget.isSelecting ? 16 : 0,
        ),
        onTap: (!widget.isFromDetail) ? _selectLocation : null,
        markers: myLatLng == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: myLatLng,
                ),
              },
      ),
    );
  }
}

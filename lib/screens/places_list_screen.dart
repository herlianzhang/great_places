import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Text('Got no places yet, start adding some place'),
                  ),
                  builder: (context, value, child) {
                    return value.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(value.items[index].image),
                                ),
                                title: Text(value.items[index].title),
                                subtitle:
                                    Text(value.items[index].location.address),
                                onTap: () => Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: value.items[index].id)),
                          );
                  },
                ),
        ),
      ),
    );
  }
}

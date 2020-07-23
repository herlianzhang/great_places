import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<GreatPlaces>(
          child: Center(
            child: Text('Got no places yet, start adding some!'),
          ),
          builder: (context, value, child) {
            return value.items.length <= 0
                ? child
                : ListView.builder(
                    itemCount: value.items.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(value.items[index].image),
                      ),
                      title: Text(value.items[index].title),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

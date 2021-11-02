import 'package:flutter/material.dart';
import 'package:zaid_study/paralax/location.dart';

class ParalaxHome extends StatefulWidget {
  const ParalaxHome({Key key}) : super(key: key);

  @override
  _ParalaxHomeState createState() => _ParalaxHomeState();
}

class _ParalaxHomeState extends State<ParalaxHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PARALLAX"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final location in locations)
                LocationListItem(
                  imageUrl: location.imageUrl,
                  name: location.name,
                  country: location.place,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

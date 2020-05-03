import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:worldtimeapp/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List locations = [];

  Future<void> getAllLocations() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/');
      var data = convert.jsonDecode(response.body);
      setState(() {
        locations = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSelectedLocation(getLocation) async {
    try {
      WorldTime instance = new WorldTime(
          location: getLocation, url: getLocation);
      await instance.getTime();
      Navigator.pop(context, {
        'location': instance.location,
        'time': instance.time,
        'isDaytime': instance.isDaytime
      });

    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text(
          'Choose a location',
          textAlign: TextAlign.left,
        ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                getSelectedLocation(locations[index]);
              },
              title: Text(locations[index]),
            ),
          );
        },
      ),
    );
  }
}

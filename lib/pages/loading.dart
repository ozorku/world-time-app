import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String displayTime = 'loading...';

  void setUpWorldTime() async {
    WorldTime instance = new WorldTime(
        location: 'Africa/Lagos', url: 'Africa/Lagos');
    await instance.getTime();

    setState(() {
      displayTime = instance.time;

      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'time': instance.time,
        'isDaytime': instance.isDaytime
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}

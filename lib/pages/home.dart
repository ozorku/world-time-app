import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: data['isDaytime'] ? Colors.white : Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                data['isDaytime'] ? 'assets/day.png' : 'assets/night.png',
                width: 80,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                data['location'],
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: data['isDaytime'] ? Colors.black : Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                '- ' + data['time'] + ' -',
                style: TextStyle(fontSize: 38, color: data['isDaytime'] ? Colors.black : Colors.white),
              ),
            ),
            SizedBox(height: 20),
            FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/choose_location');
                setState(() {
                  data = {
                    'location': result['location'],
                    'time': result['time'],
                    'isDaytime': result['isDaytime']
                  };
                });
                  },
                label: Text(
                  'Change Location',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
                icon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}

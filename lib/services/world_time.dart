import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String url; // location url for API endpoint
  bool isDaytime;

  WorldTime({this.location, this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = convert.jsonDecode(response.body);

      // get property from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String location = data['timezone'];

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch(e) {
      print('caught error: $e');
      time = 'Something went wrong, please try again';
    }
  }
}


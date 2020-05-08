import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; //formats time in friendly way, eg. 12:56 PM, used in DateFormar.jm()..

class WorldTime {
  String location; //location name for ui
  String time; //time in that location
  String flag; //url to asset flag icon
  String url;
  bool isDaytime;
  WorldTime({this.location, this.flag, this.url,});

  Future<void> getTime() async {
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
//    print(datetime);
//    print(offset);

      DateTime now = DateTime.parse(datetime);
//    print(now);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      time = 'Could not get time data.';
    }
  }
}


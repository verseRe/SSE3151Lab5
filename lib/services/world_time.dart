import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offsetSign = data['utc_offset'].substring(0,1);

      DateTime now = DateTime.parse(datetime);
      if (offsetSign == '+') {
        now = now.add(Duration(hours: int.parse(offset) ));
      }
      else {
        now= now.subtract(Duration(hours: int.parse(offset)));
      }
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print(e);
      time = 'Could not get time data';
    }

  }
}
import 'dart:convert';
import 'package:weather_app/json_to_weather_seven.dart';
import 'package:weather_app/json_to_weather.dart';
import 'package:http/http.dart';

class Network{
  Future<json_to_weather> getCurrentWeather({required String city}) async{
    var finalUrl = "https://api.openweathermap.org/data/2.5/weather?q=" + city+"&appid=2e28a5db8d3fb0a813efb1a323c362a3";
    final response = await get(Uri.parse(finalUrl));

    if(response.statusCode == 200){
      return json_to_weather.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting weather");
    }
  }

  Future<json_to_weather_seven> getWeather({required double lon, required double lat}) async{
    var finalUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=" + lat.toString() +"&lon="+lon.toString()+"&appid=2e28a5db8d3fb0a813efb1a323c362a3";
    final response = await get(Uri.parse(finalUrl));

    if(response.statusCode == 200){
      return json_to_weather_seven.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting weather");
    }
  }
}
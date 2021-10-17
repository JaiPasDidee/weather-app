import 'package:flutter/material.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'json_to_weather.dart';
import 'json_to_weather_seven.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'network.dart';
class weather_cubit extends Cubit<weather_model>{
  List<weather> _list = [weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0),weather("Paris", 2, 1.9, "Clear", 1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0)];

  weather_cubit() : super(weather_model([weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0),weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0), weather("Paris", 2, 1.9, "Clear",1000, "Clear sun", 0)]));

  void update(json_to_weather test, json_to_weather_seven test2) {
    print('ICI cubit name ${test.name}');
    _list[0] = weather(test.name, test2.current.humidity, test2.current.temp, test2.current.weather[0].main, test2.current.pressure, test2.current.weather[0].description, test2.current.rain.d1h);
    _list[1] = weather(test.name, test2.daily[0].humidity, test2.daily[0].temp.day,test2.daily[0].weather[0].main, test2.daily[0].pressure, test2.daily[0].weather[0].description, test2.daily[0].rain);
    _list[2] = weather(test.name, test2.daily[1].humidity, test2.daily[1].temp.day, test2.daily[1].weather[0].main, test2.daily[1].pressure, test2.daily[1].weather[0].description, test2.daily[1].rain);
    _list[3] = weather(test.name, test2.daily[2].humidity, test2.daily[2].temp.day, test2.daily[2].weather[0].main, test2.daily[2].pressure, test2.daily[2].weather[0].description, test2.daily[2].rain);
    _list[4] = weather(test.name, test2.daily[3].humidity, test2.daily[3].temp.day, test2.daily[3].weather[0].main, test2.daily[3].pressure, test2.daily[3].weather[0].description, test2.daily[3].rain);
    emit(weather_model(_list));
  }


  Widget updateSky(String _responseSky, double size){
    switch(_responseSky){
      case "Clouds" :
        return Icon(FontAwesomeIcons.cloud, color: Colors.grey, size: size,);
        break;
      case "Clear":
        return Icon(FontAwesomeIcons.sun, color: Colors.yellowAccent, size: size,);
        break;
      case "Rain":
        return Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: size,);
        break;
      case "Snow":
        return Icon(FontAwesomeIcons.snowman, color: Colors.white60, size: size,);
        break;
      default:
        return Icon(FontAwesomeIcons.sun, color: Colors.yellowAccent, size: size,);
        break;
    }
  }
}
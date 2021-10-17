import 'package:flutter/material.dart';
import 'package:weather_app/weather.dart';
class weather_model{
  List<weather> _list_weather;

  weather_model(this._list_weather);

  List<weather> get list_weather => _list_weather;

  set list_weather(List<weather> value) {
    _list_weather = value;
  }
}
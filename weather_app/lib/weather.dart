import 'package:flutter/material.dart';
class weather{
  String _city_name;
  int _humidity;
  double _temperature;
  String _sky;
  int _pressure;
  double _precipitation;
  String _detail_sky;

  weather(this._city_name, this._humidity, this._temperature, this._sky, this._pressure, this._detail_sky, this._precipitation);

  double get precipitation => _precipitation;

  set precipitation(double value) {
    _precipitation = value;
  }

  String get detail_sky => _detail_sky;

  set detail_sky(String value) {
    _detail_sky = value;
  }

  int get pressure => _pressure;

  set pressure(int value) {
    _pressure = value;
  }

  String get sky => _sky;

  set sky(String value) {
    _sky = value;
  }

  double get temperature => _temperature;

  set temperature(double value) {
    _temperature = value;
  }

  int get humidity => _humidity;

  set humidity(int value) {
    _humidity = value;
  }

  String get city_name => _city_name;

  set city_name(String value) {
    _city_name = value;
  }
}

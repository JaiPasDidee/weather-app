class json_to_weather_seven {
  double lat =0;
  double lon=0;
  String timezone="";
  int timezoneOffset=0;
  Current current = Current(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, <Weather>[], Rain(0,0));
  List<Daily> daily = <Daily>[];

  json_to_weather_seven(
      this.lat,
        this.lon,
        this.timezone,
        this.timezoneOffset,
        this.current,
        this.daily);

  json_to_weather_seven.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] != null ? json['lat'].toDouble() :0.0;
    lon = json['lon'] != null ? json['lon'].toDouble():0.0;
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : Current(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, <Weather>[], Rain(0,0));
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily.add(new Daily.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['timezone_offset'] = this.timezoneOffset;
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    if (this.daily != null) {
      data['daily'] = this.daily.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Current {
  int dt =0;
  int sunrise=0;
  int sunset=0;
  double temp=0;
  double feelsLike=0;
  int pressure=0;
  int humidity=0;
  double dewPoint=0;
  int clouds=0;
  int visibility=0;
  double windSpeed=0;
  int windDeg=0;
  double windGust=0;
  List<Weather> weather=[];
  late Rain rain;

  Current(
      this.dt,
        this.sunrise,
        this.sunset,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.clouds,
        this.visibility,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
      this.rain);

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? json['temp'].toDouble():0.0;
    feelsLike = json['feels_like'] != null ? json['feels_like'].toDouble():0.0;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'] != null ? json['dew_point'].toDouble():0.0;
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'] != null ? json['wind_speed'].toDouble():0.0;
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'] != null ? json['wind_gust'].toDouble():0.0;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    rain =
    (json['rain'] != null ? new Rain.fromJson(json['rain']) : new Rain(0,0));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['clouds'] = this.clouds;
    data['visibility'] = this.visibility;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.rain != null) {
      data['rain'] = this.rain.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rain {
  late double _d3h;
  late double _d1h;


  Rain(this._d3h, this._d1h);

  double get d3h => _d3h;

  set d3h(double d3h) => _d3h = d3h;


  double get d1h => _d1h;

  set d1h(double value) {
    _d1h = value;
  }

  Rain.fromJson(Map<String, dynamic> json) {
    _d3h = (json['3h'] != null) ? json['3h'].toDouble() : 0;
    _d1h = (json['1h'] != null) ? json['1h'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this._d3h;
    data['1h']= this._d1h;
    return data;
  }
}

class Weather {
  int id = 0;
  String main ="";
  String description = "";
  String icon = "";

  Weather(this.id, this.main, this.description, this.icon);

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}



class Daily {
  int dt =0;
  int sunrise=0;
  int sunset=0;
  int moonrise=0;
  int moonset=0;
  double moonPhase=0;
  Temp temp= Temp(0,0,0,0,0);
  FeelsLike feelsLike=FeelsLike(0, 0, 0);
  int pressure=0;
  int humidity=0;
  double dewPoint=0;
  double windSpeed=0;
  int windDeg=0;
  double windGust=0;
  List<Weather> weather=[];
  int clouds=0;
  double rain=0;

  Daily(
      this.dt,
        this.sunrise,
        this.sunset,
        this.moonrise,
        this.moonset,
        this.moonPhase,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.clouds,
        this.rain);

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'] != null ?  json['moon_phase'].toDouble() :0.0;
    temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : Temp(0, 0, 0, 0,  0);
    feelsLike = json['feels_like'] != null
        ? new FeelsLike.fromJson(json['feels_like'])
        : FeelsLike(0, 0, 0);
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'] != null ? json['dew_point'].toDouble() :0.0;
    windSpeed = json['wind_speed'] != null ? json['wind_speed'].toDouble():0.0;
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'] != null ? json['wind_gust'].toDouble() : 0.0;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    clouds = json['clouds'];
    rain =json['rain'] != null ?  json['rain'].toDouble() :0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['moonrise'] = this.moonrise;
    data['moonset'] = this.moonset;
    data['moon_phase'] = this.moonPhase;
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    if (this.feelsLike != null) {
      data['feels_like'] = this.feelsLike.toJson();
    }
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['dew_point'] = this.dewPoint;
    data['wind_speed'] = this.windSpeed;
    data['wind_deg'] = this.windDeg;
    data['wind_gust'] = this.windGust;
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['clouds'] = this.clouds;
    data['rain'] = this.rain;
    return data;
  }
}

class Temp {
  double day = 0;
  double min =0;
  double max=0;
  double night=0;
  double morn=0;

  Temp(this.day, this.min, this.max, this.night, this.morn);

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? json['day'].toDouble() : 0.0;
    min = json['min'] != null ? json['min'].toDouble():0.0;
    max = json['max'] != null ?json['max'].toDouble() : 0.0;
    night =json['night'] != null ? json['night'].toDouble() : 0.0;
    morn = json['morn'] != null ?json['morn'].toDouble(): 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['min'] = this.min;
    data['max'] = this.max;
    data['night'] = this.night;
    data['morn'] = this.morn;
    return data;
  }
}

class FeelsLike {
  double day = 0.0;
  double night =0;
  double morn =0;

  FeelsLike(this.day, this.night, this.morn);

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? json['day'].toDouble() : 0.0;
    night = json['night'] != null ? json['night'].toDouble() :0.0;
    morn = json['morn'] != null ? json['morn'].toDouble() : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    data['morn'] = this.morn;
    return data;
  }
}

import 'package:weather_app/weather.dart';


class json_to_weather {
  Coord coord = Coord(0.0, 0.0);
  List<Weather2> weather = [];
  String base ="";
  Main main = Main(0.0, 0.0, 0.0, 0.0, 0, 0);
  int visibility = 0;
  Wind wind =Wind(0.0, 0);
  Clouds clouds = Clouds(0);
  int dt = 0;
  Sys sys = Sys(0, 0, 0.0, "", 0, 0);
  int timezone =0;
  int id = 0;
  String name = "";
  int cod = 0;

  json_to_weather(
      this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod);

  json_to_weather.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : Coord(0.0, 0.0);
    if (json['weather'] != null) {
      weather = <Weather2>[];
      json['weather'].forEach((v) {
        weather.add(new Weather2.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : Main(0.0, 0.0, 0.0, 0.0, 0, 0);
    visibility = json['visibility'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : Wind(0.0, 0);
    clouds = json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : Clouds(0);
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : Sys(0, 0, 0.0, "", 0, 0);
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    data['visibility'] = this.visibility;
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double lon =  0.0;
  double lat = 0.0;

  Coord(this.lon, this.lat);

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] != null ? json['lon'].toDouble():0.0;
    lat = json['lat'] != null ? json['lat'].toDouble():0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather2 {
  int id = 0;
  String main = "";
  String description = "";
  String icon = "";

  Weather2(this.id, this.main, this.description, this.icon);

  Weather2.fromJson(Map<String, dynamic> json) {
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

class Main {
  double temp =0.0;
  double feelsLike = 0.0;
  double tempMin = 0.0;
  double tempMax =0.0;
  int pressure =0;
  int humidity =0;

  Main(
      this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.pressure,
        this.humidity);

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? json['temp'].toDouble():0.0;
    feelsLike =json['feels_like'] != null ?  json['feels_like'].toDouble():0.0;
    tempMin = json['temp_min'] != null ? json['temp_min'].toDouble():0.0;
    tempMax = json['temp_max'] != null ? json['temp_max'].toDouble():0.0;
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    return data;
  }
}

class Wind {
  double speed = 0.0;
  int deg = 0;

  Wind(this.speed, this.deg);

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] != null ? json['speed'].toDouble():0.0;
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Clouds {
  int all = 0;

  Clouds(this.all);

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  int type = 0;
  int id =0;
  double message =0.0;
  String country ="";
  int sunrise =0;
  int sunset =0;

  Sys(
      this.type,
        this.id,
        this.message,
        this.country,
        this.sunrise,
        this.sunset);

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    message = json['message'] != null ? json['message'].toDouble():0.0;
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['message'] = this.message;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
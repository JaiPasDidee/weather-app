import 'package:flutter/material.dart';
// @dart=2.9
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/json_to_weather.dart';
import 'package:weather_app/weather_cubit.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/network.dart';
import  'package:weather_app/json_to_weather_seven.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => weather_cubit(),
        child: _MyHomePageState(),
      ),
    );
  }
}

class _MyHomePageState extends StatelessWidget {

  final now = new DateTime.now();
  late String _date;
  String city = "paris";
  late List<String> _days = ["", "", "", ""];
  json_to_weather test = json_to_weather(Coord(0.0, 0.0),[],"",Main(0.0, 0.0, 0.0, 0.0, 0, 0),0,Wind(0.0, 0),Clouds(0),0,Sys(0, 0, 0.0, "", 0, 0),0,0,"",0);

  void init(){
     var tomorrow = new DateTime(now.year , now.month, now.day +1);
     var d2 = new DateTime(now.year , now.month, now.day +2);
     var d3 = new DateTime(now.year , now.month, now.day +3);
     var d4 = new DateTime(now.year , now.month, now.day +4);
    _date = DateFormat('EEEE, d MMM, yyyy').format(now);
     _days[0] =  DateFormat('EEEE').format(tomorrow);
     _days[1] =  DateFormat('EEEE').format(d2);
     _days[2] =  DateFormat('EEEE').format(d3);
     _days[3] =  DateFormat('EEEE').format(d4);

  }

  Future<json_to_weather_seven> init_cubit(String city) async {
    test = await Network().getCurrentWeather(city: city);
  json_to_weather_seven test2 = await Network().getWeather(lon: test.coord.lon, lat: test.coord.lon);
  return test2;
  }

  void update(String city, BuildContext context) async{
    json_to_weather test3 = await Network().getCurrentWeather(city: city);
    json_to_weather_seven test2 = await Network().getWeather(lon: test3.coord.lon, lat: test3.coord.lon);
    context.read<weather_cubit>().update(test3, test2);
  }

  @override
  Widget build(BuildContext context)  {
    init();
    return Scaffold(
      body: Center(
        child:
          SingleChildScrollView(
        child: FutureBuilder(
          future: init_cubit(city),
          builder: (BuildContext context, AsyncSnapshot<json_to_weather_seven> snapshot){
            List<Widget> children = [];
            if(snapshot.hasData){
              context.read<weather_cubit>().update(test, snapshot.requireData);
              children = <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.03,
                    ),
                    Expanded (
                      flex : 9,
                      child : TextField(
                      onSubmitted : (String value) {
                        this.city = value.toLowerCase();
                        update(city, context);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.8), width: 2.0),
                        ),
                        hintText: 'City Name',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    Expanded(
                      flex : 1,
            child : Icon(FontAwesomeIcons.search, color: Colors.white.withOpacity(0.8), size: MediaQuery.of(context).size.width/13),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02,
                ),
                BlocBuilder<weather_cubit,weather_model>(
                    builder: (context, model) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.white, size: MediaQuery.of(context).size.width/12),
                      Text(
                      '${model.list_weather[0].city_name}',
                        overflow: TextOverflow.ellipsis,
                        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0, color: Colors.white),
                      ),
                        ],
                      );
                    }
                ),

                Text(
                  '$_date',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.01,
                ),
                BlocBuilder<weather_cubit,weather_model>(
                    builder: (context, model) {
                      return context.read<weather_cubit>().updateSky(
                          model.list_weather[0].sky, MediaQuery
                          .of(context)
                          .size
                          .width / 2.5);
                    }
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    BlocBuilder<weather_cubit,weather_model>(
                        builder: (context, model) {
                          return Text(
                            '${model.list_weather[0].temperature} °F',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, fontWeightDelta: 2, color: Colors.white.withOpacity(0.8)),
                          );
                        }
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    Icon(FontAwesomeIcons.temperatureHigh, color: Colors.red, size: MediaQuery.of(context).size.width/15,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    BlocBuilder<weather_cubit,weather_model>(
                        builder: (context, model) {
                          return Text(
                            '${model.list_weather[0].detail_sky}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8)),
                          );
                        }
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        BlocBuilder<weather_cubit,weather_model>(
                            builder: (context, model) {
                              return Text(
                                '${model.list_weather[0].pressure} ips ',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white.withOpacity(0.8)),
                              );
                            }
                        ),
                        Icon(FontAwesomeIcons.bars, color: Colors.orange, size: MediaQuery.of(context).size.width/25,),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    Column(
                      children: [
                        BlocBuilder<weather_cubit,weather_model>(
                            builder: (context, model) {
                              return Text(
                                '${model.list_weather[0].humidity}% ',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8)),
                              );
                            }
                        ),
                        Icon(FontAwesomeIcons.tint, color: Colors.blue, size: MediaQuery.of(context).size.width/25,),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01,
                    ),
                    Column(
                      children: [
                        BlocBuilder<weather_cubit,weather_model>(
                            builder: (context, model) {
                              return Text(
                                ' ${model.list_weather[0].precipitation}mm',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.8)),
                              );
                            }
                        ),
                        Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: MediaQuery.of(context).size.width/25,),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02,
                ),
                Text(
                  'Others days',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style:  DefaultTextStyle.of(context).style.apply(fontWeightDelta: 2, fontSizeFactor: 2.0, color: Colors.white),
                ),


                Container(
                  height: MediaQuery.of(context).size.height/4,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children : [
                      Row(
                        children: [
                           Container(
                              width: MediaQuery.of(context).size.width/2.2,
                             decoration: BoxDecoration(
                                 color: Colors.white.withOpacity(0.3),
                                 borderRadius: BorderRadius.all(Radius.circular(20))
                             ),
                              height:MediaQuery.of(context).size.height/5,
                              alignment: Alignment.center,
                              child: Column(

                                children: [
                                  Text(
                                    _days[0],
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height/5 *
                                        0.03,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocBuilder<weather_cubit,weather_model>(
                                          builder: (context, model) {
                                            return Text(
                                              '${model.list_weather[1].temperature} °F',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3, fontWeightDelta: 2, color: Colors.white),
                                            );
                                          }
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.02,
                                      ),
                                      Icon(FontAwesomeIcons.temperatureHigh, color: Colors.red, size: MediaQuery.of(context).size.width/20,),

                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height/5 *
                                        0.03,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BlocBuilder<weather_cubit,weather_model>(
                                          builder: (context, model) {
                                            return context.read<weather_cubit>().updateSky(
                                                model.list_weather[1].sky, MediaQuery
                                                .of(context)
                                                .size
                                                .width / 10);
                                          }
                                      ),

                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.02,
                                      ),

                                      BlocBuilder<weather_cubit,weather_model>(
                                          builder: (context, model) {
                                            return Text(
                                              '${model.list_weather[1].detail_sky}',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontWeight: FontWeight.bold, color : Colors.white),
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height/5 *
                                        0.08,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          BlocBuilder<weather_cubit,weather_model>(
                                              builder: (context, model) {
                                                return Text(
                                                  '${model.list_weather[1].pressure} ips ',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                                );
                                              }
                                          ),
                                          Icon(FontAwesomeIcons.bars, color: Colors.orange, size: MediaQuery.of(context).size.width/25,),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.01,
                                      ),
                                      Column(
                                        children: [
                                          BlocBuilder<weather_cubit,weather_model>(
                                              builder: (context, model) {
                                                return Text(
                                                  '${model.list_weather[1].humidity}% ',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                );
                                              }
                                          ),
                                          Icon(FontAwesomeIcons.tint, color: Colors.blue, size: MediaQuery.of(context).size.width/25,),
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.01,
                                      ),
                                      Column(
                                        children: [
                                          BlocBuilder<weather_cubit,weather_model>(
                                              builder: (context, model) {
                                                return Text(
                                                  ' ${model.list_weather[1].precipitation}mm',
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                );
                                              }
                                          ),
                                          Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: MediaQuery.of(context).size.width/25,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.01,
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            height:MediaQuery.of(context).size.height/5,
                            alignment: Alignment.center,
                            child: Column(

                              children: [
                                Text(
                                  _days[1],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[2].temperature} °F',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3, fontWeightDelta: 2, color: Colors.white),
                                          );
                                        }
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Icon(FontAwesomeIcons.temperatureHigh, color: Colors.red, size: MediaQuery.of(context).size.width/20,),

                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return context.read<weather_cubit>().updateSky(
                                              model.list_weather[2].sky, MediaQuery
                                              .of(context)
                                              .size
                                              .width / 10);
                                        }
                                    ),

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),

                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[2].detail_sky}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, color : Colors.white),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.08,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[2].pressure} ips ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.bars, color: Colors.orange, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[2].humidity}% ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.tint, color: Colors.blue, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                ' ${model.list_weather[2].precipitation}mm',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.01,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            height:MediaQuery.of(context).size.height/5,
                            alignment: Alignment.center,
                            child: Column(

                              children: [
                                Text(
                                  _days[2],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[3].temperature} °F',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3, fontWeightDelta: 2, color: Colors.white),
                                          );
                                        }
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Icon(FontAwesomeIcons.temperatureHigh, color: Colors.red, size: MediaQuery.of(context).size.width/20,),

                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return context.read<weather_cubit>().updateSky(
                                              model.list_weather[3].sky, MediaQuery
                                              .of(context)
                                              .size
                                              .width / 10);
                                        }
                                    ),

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),

                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[3].detail_sky}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, color : Colors.white),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.08,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[3].pressure} ips ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.bars, color: Colors.orange, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[3].humidity}% ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.tint, color: Colors.blue, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                ' ${model.list_weather[3].precipitation}mm',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.01,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            height:MediaQuery.of(context).size.height/5,
                            alignment: Alignment.center,
                            child: Column(

                              children: [
                                Text(
                                  _days[3],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[4].temperature} °F',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3, fontWeightDelta: 2, color: Colors.white),
                                          );
                                        }
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Icon(FontAwesomeIcons.temperatureHigh, color: Colors.red, size: MediaQuery.of(context).size.width/20,),

                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.03,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return context.read<weather_cubit>().updateSky(
                                              model.list_weather[4].sky, MediaQuery
                                              .of(context)
                                              .size
                                              .width / 10);
                                        }
                                    ),

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),

                                    BlocBuilder<weather_cubit,weather_model>(
                                        builder: (context, model) {
                                          return Text(
                                            '${model.list_weather[4].detail_sky}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, color : Colors.white),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/5 *
                                      0.08,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[4].pressure} ips ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.bars, color: Colors.orange, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                '${model.list_weather[4].humidity}% ',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.tint, color: Colors.blue, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Column(
                                      children: [
                                        BlocBuilder<weather_cubit,weather_model>(
                                            builder: (context, model) {
                                              return Text(
                                                ' ${model.list_weather[4].precipitation}mm',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                              );
                                            }
                                        ),
                                        Icon(FontAwesomeIcons.cloudRain, color: Colors.white, size: MediaQuery.of(context).size.width/25,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ];
            }
            return Container(
                decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                Color.fromARGB(255, 60, 180, 239),
                Color.fromARGB(255, 60, 90, 239),
                ]),
            ),
            height: MediaQuery.of(context).size.height,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: children,
            ),
            );
          },
        ),
      ),
    ),

    );
  }
}

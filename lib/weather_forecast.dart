
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'UI/bottom_view.dart';
import 'UI/mid_view.dart';
import 'UI/second_route.dart';
import 'model/weather_forecast_model.dart';
import 'model/weather_forecast_model.dart';
import 'network/network.dart';


class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<WeatherForecastModel> forecastObject;
  String _cityName;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(" I am init state");
//    forecastObject = getWeather(cityName: _cityName);

    forecastObject = getLocation();
//    forecastObject.then((weather) {
//        print(weather.list[0].weather[0].main);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
//          getLocat(),
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
                future: forecastObject,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherForecastModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        MidView(snapshot: snapshot),
                        //midView(snapshot),
                        BottomView(snapshot: snapshot),
                        //bottomView(snapshot, context)
                        FloatingActionButton(
                          child: Icon(Icons.show_chart),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondRoute()),
                            );
                          },
                          backgroundColor: Colors.blue,
                        )
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Enter City Name Ex: Guntur",
              prefixIcon: Icon(Icons.search),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.all(8)),
          onSubmitted: (value) {
            setState(() {
              _cityName = value;
              forecastObject = getWeather(cityName: _cityName);
//              forecastObject = getLocation();

            });
          },
        ),
      ),
    );
  }

  Future<WeatherForecastModel> getWeather({String cityName}) {
    return new Network().getWeatherForecast(cityName: _cityName);
  }


  Future<WeatherForecastModel> getLocation() async{
    print("Stupid");
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    print(position.latitude);
    print(position.longitude);
    return new Network().getWeatherFore(lats:position.latitude.toString(), long:position.longitude.toString()) ;
  }

//  Widget getLocat() {
//    return Padding(
//      padding: const EdgeInsets.all(12.0),
//      child: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            FlatButton(
//              child: Text("Get location"),
//              onPressed: () {
//                getLocation();
//              },
//            ),
//          ],
//        ),
//      ),
//    );
//  }
}
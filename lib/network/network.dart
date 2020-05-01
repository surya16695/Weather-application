import 'dart:convert';
import 'dart:async';
import 'package:tempclimate/model/weather_forecast_model.dart';
import 'package:tempclimate/model/weather_forecast_model1.dart';
import 'package:tempclimate/util/forecast_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class Network {
  String _lats;
  String _long;
  Future<WeatherForecastModel> getWeatherForecast({String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?q=" +
        cityName +
        "&appid=" +
        Util.appId +
        "&units=imperial"; //change to metric or imperial

    final response = await get(Uri.encodeFull(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      // we get the actual mapped model ( dart object )
//      print("weather data: ${response.body}");
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }

  Future<WeatherForecastModel> getWeatherFore(
      {String lats, String long}) async {
    _lats = lats;
    _long = long;
    var finalUrl =
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=" +
            lats +
            "&lon=" +
            long +
            "&appid=" +
            Util.appId +
            "&units=metric"; //change to metric or imperial

    final response = await get(Uri.encodeFull(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      // we get the actual mapped model ( dart object )
      print("weather data: ${response.body}");
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }

  Future<WeatherForecastModel1> getWFH() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _lats = position.latitude.toString();
    _long = position.longitude.toString();
    var finalUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=" +
        _lats +
        "&lon=" +
        _long +
        "&appid=751d7305f6f1ef6338c0998a6fbd2ccb&units=metric"; //change to metric or imperial

    final response = await get(Uri.encodeFull(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      // we get the actual mapped model ( dart object )
      print("weather data: ${response.body}");
      return WeatherForecastModel1.fromJson(json.decode(response.body));
      print("Sucess");
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}

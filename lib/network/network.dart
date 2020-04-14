import 'dart:convert';

import 'package:tempclimate/model/weather_forecast_model.dart';
import 'package:tempclimate/util/forecast_util.dart';
import 'package:http/http.dart';

class Network{
  Future<WeatherForecastModel> getWeatherForecast(String cityName) async{
    var finalurl = "https://api.openweathermap.org/data/2.5/onecall?lat=lati&lon=long&appid="+Util.appId+"&units=metric"; //we can change metric to imperial if needed.
    final  response = await get(Uri.encodeFull(finalurl));
    if(response.statusCode == 200){
      return WeatherForecastModel.fromJson(json.decode(response.body));
      //helps in getting mapped data of weather forecast as a dart object
    }else{
      throw Exception("Error getting data from url");
    }
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tempclimate/model/weather_forecast_model1.dart';
import 'package:tempclimate/network/network.dart';

class SecondRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SecondRouteState();
  }
}

class SecondRouteState extends State<SecondRoute>{
  num _time = 0;
  Future<WeatherForecastModel1> foreCastobj;
  void initState(){
    super.initState();
    foreCastobj=  getLocation();
  }
  @override
  Widget build(BuildContext context) {
    print("am nhere");
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Time vs Temp", textAlign: TextAlign.center))
      ),
      body: Center(
          child: Container(
             alignment: Alignment.center,
                child:FutureBuilder<WeatherForecastModel1>(
                    future:foreCastobj ,
                    builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel1> snapshots) {
                      if (snapshots.hasData) {
                        print("vamsiiiiiiiii");
                        return
                          //Initialize chart
                             graphView(snapshots);
                      } else if (snapshots.hasError) {
                        print("suryaaaa here");
                        return Text("${snapshots.error}",style: Theme.of(context).textTheme.headline);
                      } else {
                        print("busterreeefew");
                        return CircularProgressIndicator();
                      }
                    }),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(
        child:Icon(Icons.access_time),
        onPressed: () {
          DatePicker.showTimePicker(context,
              theme: DatePickerTheme(
                containerHeight: 210.0,
              ),
              showTitleActions: true, onConfirm: (time) {
                print('confirm $time');
                _time = time.hour ;
                setState(() {});
              }, currentTime: DateTime.now(), locale: LocaleType.en);
          setState(() {});
        },
        backgroundColor: Colors.blue,
      ),
    );
  }
  Future<WeatherForecastModel1> getLocation() {
    print("Stupid");
      Future<WeatherForecastModel1> forecastModel1 =  new Network().getWFH() ;
      return forecastModel1;
  }
  Widget graphView( AsyncSnapshot<WeatherForecastModel1> snapshot){
    print("dumdasew");
    List<Datas> chartData = lineData(snapshot.data.hourly);
      return Container(
        padding: const EdgeInsets.all(20.0),
        height: 500,
        child: SfCartesianChart(
            trackballBehavior: TrackballBehavior(
                enable: true,
                // Displays the trackball on single tap
                activationMode: ActivationMode.singleTap
            ),
        title: ChartTitle(text: 'Temperature-Time analysis'),
        // Initialize category axis,
            tooltipBehavior: TooltipBehavior(
            enable: true,
          ),

            onTooltipRender: (TooltipArgs args) {
              print(_time);
            args.pointIndex = _time;},

            zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            ),
        primaryXAxis: NumericAxis(
          title: AxisTitle(
            text: "Time in hours",

          ),
          interval: 2
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: "Temp in Centigrade",

          ),
        ),
          series: <ChartSeries>[
          // Initialize line series
          LineSeries<Datas, num>(
          dataSource:chartData,
          xValueMapper: (Datas hour, _) => hour.date,
          yValueMapper: (Datas hour, _) => hour.temp,
          // Render the data label
//          dataLabelSettings:DataLabelSettings(isVisible : true)
          )
          ]
        ),
      );
  }

  Widget timeView(){
    return Align(
      alignment: Alignment.bottomCenter,

    );

  }

  Widget _detectWidget() {

    if (Platform.isAndroid) {

      // Return here any Widget you want to display in Android Device.
      return timeView();

    }
    else if(Platform.isIOS) {

      // Return here any Widget you want to display in iOS Device.
      return timeView();
    }
    return timeView();
  }
//  Widget timeView1(){
//    return
//  }
}


class Datas{
  int date;
  double temp;
  Datas(this.date, this.temp);
}

dynamic lineData(List<Hourly> li){
  List<Datas> l1 = <Datas>[];
  for(int i = 0; i < 24;i++){
    var date =
    new DateTime.fromMillisecondsSinceEpoch(li[i].dt * 1000);
    double t = li[i].temp;
    l1.add(Datas(date.hour, t));
  }
  return l1;
}
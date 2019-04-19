import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/blocs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './repositories/weather_repository.dart';
import 'package:date_format/date_format.dart';


class HomePage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  HomePage({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc _weatherBloc;
  WeatherDetailBloc _detailBloc;

  String timeString;
  String dayOfMonth;

  @override
  void initState() {
    super.initState();

    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _weatherBloc.dispatch(FetchWeather(locationId: 1252431));

    _detailBloc = WeatherDetailBloc(weatherRepository: widget.weatherRepository);
    _detailBloc.dispatch(FetchWeatherDetail(locationId: 353981));

    timeString = _formatDateTime(DateTime.now());
    dayOfMonth = formatDate(DateTime.now(), [D, ', ', M,' ', dd]);

    Timer.periodic(Duration(seconds: 1), (Timer timer){
      setState(() {
        timeString = _formatDateTime(DateTime.now());
      });
    });
  }

  _formatDateTime(DateTime dateTime){
    return formatDate(dateTime, [hh, ' : ', nn,' ',am]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('$timeString',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w200)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt, color: Colors.white.withOpacity(0.8)),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.menu, color: Colors.white.withOpacity(0.8) ),
              onPressed: () {})
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: BlocBuilder(
              bloc: _weatherBloc,
              builder: (BuildContext context, WeatherState state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _homeScreenTopPart(state),
                    _homeScreenDetails(),
                    _homeScreenNextHours(),
                    _homeScreenNextSevenDays(),
                    _homeScreenChanceOfPrecipitation(),
                  ],
                );
              })),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    _detailBloc.dispose();
    super.dispose();
  }

  Widget _homeScreenTopPart(WeatherState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 400.0,
                width: double.infinity,
                child:
                    Image.asset('assets/images/hochiminh.jpg', fit: BoxFit.cover),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Text( state is WeatherLoaded ? '${state.weather.temp.toInt()}°C' : '0°C',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 80,
                    fontWeight: FontWeight.w100)),
            SizedBox(width: 20.0),
            Column(
              children: <Widget>[
                Text(state is WeatherLoaded ? '${state.weather.maxTemp.toInt()}°' : '0°',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.w100)),
                SizedBox(height: 20.0)
              ],
            ),
            Text('/',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 40,
                    fontWeight: FontWeight.w100)),
            SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(state is WeatherLoaded ? '${state.weather.minTemp.toInt()}°' : '0°',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.w100)),
              ],
            ),
          ],
        ),
        Text(dayOfMonth,
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
        SizedBox(height: 10.0),
        Text(
          state is WeatherLoaded ? '${state.weather.location}' : 'Da Lat City',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        Text(
          state is WeatherLoaded ? '${state.weather.formattedCondition}' : 'Light Cloud',
          style:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16.0),
        ),
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            print('tap tap');
          },
          child: Row(
            children: <Widget>[
              Text(
                'Today - Clouds and sun; pleasant, less humid',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 14),
              ),
              Spacer(),
              Icon(Icons.play_arrow,
                  color: Colors.white.withOpacity(0.5), size: 14.0)
            ],
          ),
        ),
        SizedBox(height: 130.0)
      ],
    );
  }

  Widget _homeScreenDetails() {
    return BlocBuilder(
      bloc: _detailBloc,
      builder: (_, WeatherDetailState state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text('DETAIL',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14.0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _contentDetail(
                    context,
                    FontAwesomeIcons.temperatureHigh,
                    'Realfeel®',
                    '${state is WeatherDetailLoaded ? state.weatherDetail.realFeelTemp.toInt() : '0'}°C'),
                _contentDetail(
                    context,
                    FontAwesomeIcons.water,
                    'Humidity',
                    '${state is WeatherDetailLoaded ? state.weatherDetail.relativeHumidity : '0'}%'),
                _contentDetail(
                    context,
                    FontAwesomeIcons.solidSun,
                    'UV index',
                    '${state is WeatherDetailLoaded ? state.weatherDetail.uvIndex : '0'}'),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _contentDetail(context, FontAwesomeIcons.eye, 'Visibility', '${state is WeatherDetailLoaded ? state.weatherDetail.visibility.toInt() : '0'}km'),
                _contentDetail(context, FontAwesomeIcons.temperatureLow, 'Dew point', '${state is WeatherDetailLoaded ? state.weatherDetail.dewPoint.toInt() : '0'}°C'),
                _contentDetail(context, FontAwesomeIcons.centercode, 'Presure', '${state is WeatherDetailLoaded ? state.weatherDetail.pressure.toInt() : '0'}mb'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _contentDetail(
      BuildContext context, IconData icon, String text, String textContent) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20.0,
      height: MediaQuery.of(context).size.width / 3 - 20.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.grey[900].withOpacity(0.6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, color: Colors.grey, size: 20),
            Text(text,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w200)),
            Flexible(
              child: Text(textContent,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 36,
                      fontWeight: FontWeight.w200)),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemListView(BuildContext context, int index) {
    return Container(
      width: 50.0,
      height: 130.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: index == 0 ? Colors.grey.withOpacity(0.1) : Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('26°', style: TextStyle(color: Colors.white70, fontSize: 16.0)),
          Icon(index % 2 == 1 ? Icons.cloud_queue : Icons.brightness_3,
              size: 16.0, color: Colors.white70),
          Text('9 pm', style: TextStyle(color: Colors.grey, fontSize: 14.0))
        ],
      ),
    );
  }

  Widget _homeScreenNextHours() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
          child: Row(
            children: <Widget>[
              Text('NEXT 24 HOURS',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14.0)),
              Spacer(),
              Icon(Icons.play_arrow,
                  color: Colors.white.withOpacity(0.5), size: 14.0)
            ],
          ),
        ),
        Container(
          height: 130.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: _itemListView,
            itemCount: 24,
          ),
        )
      ],
    );
  }

  Widget _homeScreenNextSevenDays(){
        return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
          child: Row(
            children: <Widget>[
              Text('NEXT 7 DAYS',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14.0)),
              Spacer(),
              Icon(Icons.play_arrow,
                  color: Colors.white.withOpacity(0.5), size: 14.0)
            ],
          ),
        ),
        Container(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: (MediaQuery.of(context).size.width - 32) / 7,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('36°',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 16.0)),
                    Container(
                      width: 4.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.redAccent, Colors.orangeAccent]),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    ),
                    Text('26°',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 16.0)),
                    SizedBox(height: 10.0),
                    Icon(Icons.cloud_queue, color: Colors.white70, size: 16.0),
                    Text('Thu',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0))
                  ],
                ),
              );
            },
            itemCount: 7,
          ),
        ),
      ],
    );
  }

  Widget _homeScreenChanceOfPrecipitation(){
        return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
              child: Text('CHANCE OF PRECIPITATION',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 14.0))),
          Container(
            height: 200.0,
            child: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Text('100%',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  SizedBox(height: 50.0),
                  Text('50%',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  SizedBox(height: 50.0),
                  Text('0%',
                      style: TextStyle(color: Colors.white, fontSize: 16.0))
                ]),
                Expanded(
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        decoration: BoxDecoration(color: Colors.grey),
                      ),
                      Container(
                        height: 40.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('9am',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16.0)),
                            );
                          },
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          )
        ]));
  }
}
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('15:08 PM',
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
              icon: Icon(Icons.menu, color: Colors.white.withOpacity(0.8)),
              onPressed: () {})
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            HomeScreenTopPart(),
            HomeScreenDetails(),
            HomeScreenNextHours(),
            HomeScreenNextSevenDays(),
            HomeScreenChanceOfPrecipitation()
          ],
        ),
      ),
    );
  }
}

class HomeScreenTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Container(
                height: 400.0,
                child:
                    Image.asset('assets/images/sydney.jpeg', fit: BoxFit.cover),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Text('36°C',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 80,
                    fontWeight: FontWeight.w100)),
            SizedBox(width: 20.0),
            Column(
              children: <Widget>[
                Text('37°',
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
                Text('28°',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.w100)),
              ],
            ),
          ],
        ),
        Text('MON, APRIL 15',
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
        SizedBox(height: 10.0),
        Text(
          'Ho Chi Minh City',
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
        Text(
          'Partly Sunny',
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
}

class HomeScreenDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            _contentDetail(context, Icons.flash_on, 'Realfeel', '36°C'),
            _contentDetail(context, Icons.flash_on, 'Humidity', '78%'),
            _contentDetail(context, Icons.flight, 'UV index', '0'),
          ],
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _contentDetail(context, Icons.flash_on, 'Visibility', '16km'),
            _contentDetail(context, Icons.flash_on, 'Dew point', '26°C'),
            _contentDetail(context, Icons.flash_on, 'Presure', '1008mb'),
          ],
        ),
      ],
    );
  }

  _contentDetail(
      BuildContext context, IconData icon, String text, String textContent) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 - 20.0,
      height: 120.0,
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
            Text(textContent,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 36,
                    fontWeight: FontWeight.w200))
          ],
        ),
      ),
    );
  }
}

class HomeScreenNextHours extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
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
}

class HomeScreenNextSevenDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class HomeScreenChanceOfPrecipitation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            decoration: BoxDecoration(
                              color: Colors.grey
                            ),
                          ),
                          Container(
                            height: 40.0,
                            child:                           ListView.builder(
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
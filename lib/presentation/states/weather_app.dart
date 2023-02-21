// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.

/// Hi, OpenWeather's Api Subscription process was a failure. It declined my card about 
/// five times trying. That's why i had to hardcode the data I'd have otherwise gotten 
/// from making requests to the api




import 'dart:ui';


import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/presentation/widgets/tabs_widget.dart';

import '../../weather_app_core/read_write/read_write.dart';
import '../bloc/weather_app_bloc.dart';
import '../widgets/add_city_widget.dart';

class WeatherApp extends StatefulWidget {

  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();

}

class _WeatherAppState extends State<WeatherApp> with SingleTickerProviderStateMixin {

  late List<Map<String, dynamic>?>? cities;
  late List<String>? keys;

  late double longitude;
  late double latitude;

  late TabController tabController;
  int selectedIndex = 0;



  @override 
  Future<void> initState() async {

    cities = [];
    cities!.insert(0, await readCities());

    keys = await readCityKeys();

    tabController = TabController(length: cities!.length, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {BlocProvider.of<WeatherAppBloc>(context).add(GetWeatherDataEvent(cities![selectedIndex]![keys![selectedIndex]]['data']['longitude'], cities![selectedIndex]![keys![selectedIndex]]['data']['latitude']));},
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(color: Colors.transparent),
                )
              ),
            centerTitle: true,
            title: Column(mainAxisSize: MainAxisSize.min, children: [Text(cities != null? cities![selectedIndex]![keys![selectedIndex]]['data']['city'] : 'Meta Verse', style: Theme.of(context).textTheme.titleLarge), ListView.builder(scrollDirection: Axis.horizontal,  itemCount: cities!.length, itemBuilder: (context, index) => Text('*', style: Theme.of(context).textTheme.headline3),)   ]),
            leading: InkWell(onTap: (){Navigator.push(context,  MaterialPageRoute<void>( builder: (BuildContext context) => const AddCityWidget())); }, child: const Icon(FontAwesomeIcons.plus, color: Colors.black)),
            actions: [IconButton(onPressed: () async {getLiveForecasts(); BlocProvider.of<WeatherAppBloc>(context).add(GetWeatherDataEvent(latitude, longitude));}, icon: const FaIcon(FontAwesomeIcons.mapPin),)],
          ),

          body: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: cities!.map((e) => TabsWidget(e![keys![selectedIndex]]['data']['longitude'], e['data']['latitude'])).toList(),
          ),
        )
      ),
    );
  }

Future<Position> getLiveForecasts() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are denied permanently. Cannot request permission. Try disabling this and try again');
  }

  setState(() async {longitude = await Geolocator.getCurrentPosition().then((value) => value.longitude); latitude = await Geolocator.getCurrentPosition().then((value) => value.latitude);});


  return await Geolocator.getCurrentPosition();
}


  @override 
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

}
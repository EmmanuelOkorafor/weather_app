// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 21/02/23.





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_app_bloc.dart';

// import '../../weather_app_core/temperature_conversion/temperature_conversion.dart';
import '../../weather_app_injection_container.dart';

class TabsWidget extends StatefulWidget {

  final double? longitude;
  final double? latitude;

  const TabsWidget(this.longitude, this.latitude,  {Key? key}) : super(key: key);

  @override
  State<TabsWidget> createState() => _TabsWidgetState();

}

class _TabsWidgetState extends State<TabsWidget> {

  late Map<String, dynamic>? cord;
  late List<Map<String, dynamic>>? weather;
  late String? base;
  late Map<String, dynamic>? main;
  late String? visibility;
  late Map<String, dynamic>? wind;
  late Map<String, dynamic>? rain;
  late Map<String, dynamic>? clouds;
  late String? dt;
  late Map<String, dynamic>? sys;
  late String? timezone;
  late String? id;
  late String? name;
  late String? cod;

  late bool isLoading;


  @override 
  void initState() {
    BlocProvider.of<WeatherAppBloc>(context).add(GetWeatherDataEvent(widget.latitude, widget.longitude));
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // sl - Dependency Injection
      create: ((context) => sl<WeatherAppBloc>()),
      child: BlocConsumer(
        listener: ((context, state) {if (state is Err) { SnackBar(width: MediaQuery.of(context).size.width * 0.35, padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), content: Text(state.message!, style: Theme.of(context).textTheme.labelLarge), elevation: 2.0, shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),); }}),
        builder: ((context, state) {
          if (state is WeatherAppInitial) {
            return Container();
          
          } else 
          if (state is WeatherAppLoading) {
            setState(() {isLoading = true;});
          
          } else 
          if (state is WeatherAppLoaded) {
            setState(() {setState(() {isLoading = false; Map<String, dynamic>? cord = state.entity.cord; List<Map<String, dynamic>>? weather = state.entity.weather; String? base = state.entity.base; Map<String, dynamic>? main = state.entity.main; String? visibility = state.entity.visibility; Map<String, dynamic>? wind = state.entity.wind; Map<String, dynamic>? rain = state.entity.rain; Map<String, dynamic>? clouds = state.entity.clouds; String? dt = state.entity.dt; Map<String, dynamic>? sys = state.entity.sys; String? timezone = state.entity.timezone; String? id = state.entity.id; String? name = state.entity.name; String? cod = state.entity.cod; });});
            return tab(context);
          
          } return Container();
        })
      ),
    );
  }

  Widget tab(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [

          Center(
            child: Column(
              children: [
                // Text(isLoading? 'Updating...' : '${toCelsius(main!['temp'])}C', style: isLoading? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.headline4),
                Text(isLoading? 'Updating...' : '-1C', style: isLoading? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.headline4),

                const SizedBox(height: 5),

                // Text(isLoading?'Updating...' : 'Feels like ${main!['feels_like']}', style: Theme.of(context).textTheme.bodyText1),
                Text(isLoading? 'Updating...' : 'Feels like -4C', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Row(children: [Text('Wind: ', style: Theme.of(context).textTheme.headline6), Text(isLoading? 'Updating...' : '5m/s N', style: Theme.of(context).textTheme.bodyText1)],),
                
                Row(children: [Text('Visibility: ', style: Theme.of(context).textTheme.headline6), Text(isLoading? 'Updating...' : '100km', style: Theme.of(context).textTheme.bodyText1)],),
                
                Row(children: [Text('Rain: ', style: Theme.of(context).textTheme.headline6), Text(isLoading? 'Updating...' : '0.0Inches', style: Theme.of(context).textTheme.bodyText1)],),

                Row(children: [Text('Humidity: ', style: Theme.of(context).textTheme.headline1), Text(isLoading? 'Updating...' : '0.9%', style: Theme.of(context).textTheme.bodyText1)],),



              ],
            ),
          )
        ],
      ),
    );
  }

}
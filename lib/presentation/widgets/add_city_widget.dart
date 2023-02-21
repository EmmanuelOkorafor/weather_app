// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.






import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/widgets/city_tiles.dart';

import '../../weather_app_core/persistence/persist.dart';

class AddCityWidget extends StatefulWidget {
  
  const AddCityWidget({Key? key}) : super(key: key);

  @override
  State<AddCityWidget> createState() => _AddCityWidgetState();
}

class _AddCityWidgetState extends State<AddCityWidget> {


  late List<Map<String, dynamic>> load;

  late SaveUserPreferredCityImpl saveUserPreferredCity;

  @override
  Future<void> initState() async {

    load = [{"data": {"longitude": 3.4000, "latitude": 6.4500, "city": "Lagos", "sc": "Lagos, Nigeria"}},  {"data": {"longitude": 8.5167, "latitude": 12.0000, "city": "Kano", "sc": "Kano, Nigeria"}}, {"data": {"longitude": 3.9167, "latitude": 7.3964, "city": "Ibadan", "sc": "Oyo, Nigeria"}}, {"data": {"longitude": 6.7833, "latitude": 6.1667, "city": "Onitsha", "sc": "Anambra, Nigeria"}}, {"data": {"longitude": 7.0333, "latitude": 5.4833, "city": "Owerri", "sc": "Imo, Nigeria"}}, {"data": {"longitude": 7.4914, "latitude": 9.0556, "city": "Abuja", "sc": "Abuja, Nigeria"}}, {"data": {"longitude": 13.1500, "latitude": 11.8333, "city": "Maiduguri", "sc": "Maiduguri, Nigeria"}}, {"data": {"longitude": 5.6145, "latitude": 6.3176, "city": "Benin City", "sc": "Edo, Nigeria"}}, {"data": {"longitude": 5.7600, "latitude": 7.5304, "city": "Ikare", "sc": "Ondo, Nigeria"}}, {"data": {"longitude": 4.2500, "latitude": 8.1333, "city": "Ogbomoso", "sc": "Oyo, Nigeria"}}, {"data": {"longitude": 7.0000, "latitude": 4.7500, "city": "PortHarcourt", "sc": "Rivers, Nigeria"}}, {"data": {"longitude": 3.3500, "latitude": 7.1500, "city": "Abeokuta", "sc": "Ogun, Nigeria"}}, {"data": {"longitude": 8.8833, "latitude": 9.9333, "city": "Jos", "sc": "Plateau, Nigeria"}}, {"data": {"longitude": 4.5500, "latitude": 8.5000, "city": "Ilorin", "sc": "Kwara, Nigeria"}}, {"data": {"longitude": 5.7500, "latitude": 5.5167, "city": "Warri", "sc": "Delta, Nigeria"}}, ];

    saveUserPreferredCity = SaveUserPreferredCityImpl(await SharedPreferences.getInstance());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.white, 
      title: 'Add City',
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(color: Colors.transparent),
                )
              ),
            title: Text('Add City', style: Theme.of(context).textTheme.titleLarge),
            leading: InkWell(onTap: (){Navigator.of(context).pop();}, child: const Icon(Icons.arrow_left, color: Colors.black)),
          ),

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                ListView.builder(
                  itemCount: load.length,
                  itemBuilder: ((context, index) => CityTilesWidget(load[index], '${load[index]['data']['city']}') )
                )

              ],
            ),
          ),
        )
      )
    );
  }


  @override 
  void dispose() {
    load.clear();
    super.dispose();
  }

}
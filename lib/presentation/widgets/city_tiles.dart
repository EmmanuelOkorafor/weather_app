// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 21/02/23.


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/weather_app_core/read_write/read_write.dart';

class CityTilesWidget extends StatefulWidget {
  
  final Map<String, dynamic> load;
  final String fileName;

  const CityTilesWidget(this.load, this.fileName, {Key? key}) : super(key: key);

  @override
  State<CityTilesWidget> createState() => _CityTilesWidgetState();
}

class _CityTilesWidgetState extends State<CityTilesWidget> {

  late bool tileClicked;

  @override
  void initState() {
    tileClicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: tileClicked? (){setState(() {tileClicked = false;}); deleteCity(widget.fileName);} : (){setState(() {tileClicked = true;}); writeCities(widget.load, widget.fileName); writeCityKeys(widget.fileName);}, title: Text(widget.load['data']['city'], style: Theme.of(context).textTheme.bodyText1), subtitle: Text(widget.load['data']['sc'], style: Theme.of(context).textTheme.labelMedium), contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0)), trailing: tileClicked? const Icon(FontAwesomeIcons.minus, color: Colors.black) : const Icon(FontAwesomeIcons.plus, color: Colors.black), tileColor: Colors.white);
  }


}
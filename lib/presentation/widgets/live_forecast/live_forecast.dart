// GetFoodCourt Ltd.
// Author: Emmanuel Okorafor, 20/02/23.




import 'package:geolocator/geolocator.dart';

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


  return await Geolocator.getCurrentPosition();
}


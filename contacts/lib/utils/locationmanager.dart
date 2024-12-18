import 'package:location/location.dart';

Location location = new Location();

bool _serviceEnabled = false;
PermissionStatus _permissionGranted = PermissionStatus.denied;
LocationData _locationData = LocationData.fromMap({
  'latitude' : 40.1925,
  'longitude' : -8.4128
});
///
/*
Future<void> initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
  }
  getLocation();
}

Future<void> getLocation() async {
  if (!_serviceEnabled ||
    _permissionGranted != PermissionStatus.granted) {
    return;
  }
  _locationData = await location.getLocation();
  setState(() {});
}

@override
Widget build(BuildContext context) {
 return ...
 ...
 Row(
 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 children: [
 Text('Lat: ${_locationData.latitude}'),
 Text('Lon: ${_locationData.longitude}')
 ],
 ),
 ElevatedButton(
 onPressed: getLocation,
 child: const Text('Get location')
 ),
 ...
}*/


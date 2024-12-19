import 'package:location/location.dart';

class LocationManager{
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData _locationData = LocationData.fromMap({
    'latitude' : 40.1925, //lat isec
    'longitude' : -8.4128 //lon isec
  }); 

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
  }//lembrar-me de fazer um setState(() {}); depois de chamar esta função nalgum lado

}



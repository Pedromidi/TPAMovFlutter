import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Contact{
  String nome = "";
  String email = "";
  int phone = 0;
  DateTime? birthdate;
  String bday = "--/--/----";
  Image picture = Image.asset("assets/defaultcontact.png");
  late List<Marker> meetingpoints = [];

  Contact(this.nome, this.email, this.phone, this.birthdate, this.picture);

  void addMeetingPoint(Marker mp){
      meetingpoints.add(mp);
  }

  String getBday(){
    if (birthdate?.day != null){
      bday = "${birthdate!.day}/${birthdate!.month}/${birthdate!.year}";
    }
    return bday;
  }

  /*Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'phone': phone,
      'birthdate': birthdate?.toIso8601String(), // Convert DateTime to a string
      'picture': picture,
      'meetingpoints': meetingpoints.map((marker) {
        return {
          'latitude': marker.point.latitude,
          'longitude': marker.point.longitude,
        };
      }).toList(),
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      json['nome'],
      json['email'],
      json['phone'],
      json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      json['picture'],
    )..meetingpoints = (json['meetingpoints'] as List<dynamic>).map((markerJson) {
        return Marker(
          point: LatLng(markerJson['latitude'], markerJson['longitude']),
          child: const Icon(Icons.location_pin, color: Colors.red),
        );
      }).toList();
  }*/
}
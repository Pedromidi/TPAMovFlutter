import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Contact{
  String nome = "";
  String email = "";
  int phone = 0;
  DateTime? birthdate;
  String bday = "--/--/----";
  //Image picture = Image.asset("assets/defaultcontact.png");
  String picturePath; //= "assets/defaultcontact.png";
  late List<Marker> meetingpoints = [];

  //Contact(this.nome, this.email, this.phone, this.birthdate, this.picture);
  Contact(this.nome, this.email, this.phone, this.birthdate, this.picturePath);

  void addMeetingPoint(Marker mp){
      meetingpoints.add(mp);
  }

  Image getImage() {
    if (picturePath.startsWith('assets/')) {
      return Image.asset(picturePath);
    } else {
      return Image.file(File(picturePath));
    }
  }


  String getBday(){
    if (birthdate?.day != null){
      bday = "${birthdate!.day}/${birthdate!.month}/${birthdate!.year}";
    }
    return bday;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'phone': phone,
      'birthdate': birthdate?.toIso8601String(),
      'picture': picturePath,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map['nome'],
      map['email'],
      map['phone'],
      map['birthdate'] != null ? DateTime.parse(map['birthdate']) : null,
      map['picture'],
    );
  }
}
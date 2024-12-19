import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Contact{
    String nome = "";
    String email = "";
    int phone = 0;
    DateTime? birthdate;
    Image picture = Image.asset("assets/defaultcontact.png");
    late List<Location> meetingpoints;

    Contact(this.nome, this.email, this.phone, this.birthdate, this.picture);

    void addMeetingPoint(Location mp){
        meetingpoints.add(mp);
    }
}
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Contact{
    String nome = "";
    String email = "";
    int phone = 0;
    DateTime? birthdate;
    Image picture = Image.asset("assets/defaultcontact.png");
    late List<Marker> meetingpoints = [];

    Contact(this.nome, this.email, this.phone, this.birthdate, this.picture);

    void addMeetingPoint(Marker mp){
        meetingpoints.add(mp);
    }
}
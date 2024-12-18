import 'package:contacts/model/meetingpoint.dart';
import 'package:flutter/material.dart';

class Contact{
    String nome = "";
    String email = "";
    int phone = 0;
    String birthdate = "";
    late Image picture = Image.asset("assets/defaultcontact.png");
    late List history;

    Contact(this.nome, this.email, this.phone, this.birthdate, this.picture);

    void addMeetingPoint(MeetingPoint mp){
        history.add(mp);
    }
}
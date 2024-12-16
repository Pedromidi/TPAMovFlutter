class MeetingPoint{
    double lat = 0;
    double long = 0;
    DateTime date = DateTime.now();
}

class Contact{
    String nome = "";
    String email = "";
    int phone = 0;
    DateTime birthdate = DateTime.now();
    bool isbirthdate = false;
    String picture = "";
    late List history;

    void addMeetingPoint(MeetingPoint mp){
        history.add(mp);
    }
}
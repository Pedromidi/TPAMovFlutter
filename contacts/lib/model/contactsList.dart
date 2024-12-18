import 'package:contacts/model/Contact.dart';

class ContactList{
  List<Contact> contactos = [];

  List<Contact> get contacts => contactos;

  void addContact(Contact c){
    contactos.add(c);
  }
}
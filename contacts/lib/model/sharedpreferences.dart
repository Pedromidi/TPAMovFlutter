import 'package:contacts/model/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String contactsKey = "contacts_list";

  static Future<void> saveContacts(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();

    // Serializar contactlist
    List<Map<String, dynamic>> contactsJson = contacts.map((contact) {
      return {
        'nome': contact.nome,
        'email': contact.email,
        'phone': contact.phone,
        'birthdate': contact.birthdate?.toIso8601String(),
        'bday': contact.bday,
        'picturePath': "assets/defaultcontact.png",
      };
    }).toList();

    // Salva a lista JSON como String no Shared Preferences
    await prefs.setString(contactsKey, jsonEncode(contactsJson));
  }

  static Future<List<Contact>> getContacts() async {
    final prefs = await SharedPreferences.getInstance();

    String? contactsJson = prefs.getString(contactsKey);
    if (contactsJson == null) return [];

    List<dynamic> contactsList = jsonDecode(contactsJson);

    return contactsList.map((contactMap) {
      return Contact(
        contactMap['nome'],
        contactMap['email'],
        contactMap['phone'],
        contactMap['birthdate'] != null
            ? DateTime.parse(contactMap['birthdate'])
            : null,
        contactMap['picturePath'],
      );
    }).toList();
  }
}

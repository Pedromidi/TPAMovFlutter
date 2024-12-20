import 'package:contacts/model/contact.dart';
import 'package:contacts/model/contactslist.dart';
import 'package:contacts/ui/contactoui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastTenEditedScreen extends StatefulWidget {
  const LastTenEditedScreen({super.key,});

  @override
  State<LastTenEditedScreen> createState() => _LastTen();
}

class _LastTen extends State<LastTenEditedScreen>{
  ContactList sharedprefscontactos = ContactList();

  /*Future<void> initContactList() async {
    var prefs = await SharedPreferences.getInstance();
    setState (() { sharedprefscontactos = prefs.get(key) ; });
  }*/

  bool hidden = true;

  void _expandContacts(){
    hidden = !hidden;
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Contactos alterados"),
        actions: [
          ElevatedButton(
            onPressed: () {
              _expandContacts();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Icon(Icons.list),
          ),
        ],
      ),
      body: Stack(
        children: [
          sharedprefscontactos.contacts.isEmpty
          ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sem contactos alterados registados',
                ),
              ],
            ),
          )
          : ListView.builder(
              itemCount: sharedprefscontactos.contacts.length,
              itemBuilder: (context, index) {
                final contact = sharedprefscontactos.contacts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactoUi(item: contact),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  child: Card(
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: contact.picture,
                        ),
                      ),
                      title: 
                        Text(
                          contact.nome,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      subtitle: !hidden
                        ? contact.birthdate?.day != null
                          ? Text(
                              "Email: ${contact.email}\nAniversário: ${contact.birthdate?.day}/${contact.birthdate?.month}/${contact.birthdate?.year}\nTelemóvel: ${contact.phone}", 
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Email: ${contact.email}\nAniversário: --/--/----\nTelemóvel: ${contact.phone}", 
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                        : null,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
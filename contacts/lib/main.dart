import 'package:contacts/model/Contact.dart';
import 'package:contacts/model/contactsList.dart';
import 'package:contacts/model/databasehelper.dart';
import 'package:contacts/ui/addContactScreen.dart';
import 'package:contacts/ui/contactoui.dart';
import 'package:contacts/ui/lastteneditedscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Contacts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  ContactList contacts = ContactList();
  bool hidden = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<Contact> loadedContacts = await loadContacts();
    setState(() {
      contacts.contactos = loadedContacts;
    });
  }

  Future<List<Contact>> loadContacts() async {
    List<Contact> contacts = await dbHelper.getContacts();
    return contacts;
  }
  

  void _addContactScreen(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddContactScreen(contactos: contacts, dbHelper: dbHelper,),
      ),
    ).then((_) => setState(() {}));
  }

  void _lastTenEditedScreen(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LastTenEditedScreen(),
      ),
    ).then((_) => setState(() {}));
  }

  void _expandContacts(){
    hidden = !hidden;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              _lastTenEditedScreen();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Icon(Icons.account_box),
          ),
          const SizedBox(width: 8),
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
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              _addContactScreen();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          contacts.contacts.isEmpty
          ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sem contactos registados',
                ),
              ],
            ),
          )
          : ListView.builder(
              itemCount: contacts.contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts.contacts[index];
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
                          child: contact.getImage(),
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
                        ? Text(
                              "Email: ${contact.email}\nAniversário: ${contact.getBday()}\nTelemóvel: ${contact.phone}", 
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                        :null,
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

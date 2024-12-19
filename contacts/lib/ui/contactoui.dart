import 'package:contacts/model/Contact.dart';
import 'package:contacts/ui/addmeetingpoint.dart';
import 'package:contacts/ui/editcontact.dart';
import 'package:flutter/material.dart';

class ContactoUi extends StatelessWidget {
  final Contact item;

  const ContactoUi({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return _ContactoUi(item: item,);
  }
}

class _ContactoUi extends StatefulWidget {
  final Contact item;

  const _ContactoUi({required this.item});

  @override
  State<_ContactoUi> createState() => _Details();
}

class _Details extends State<_ContactoUi> {

  void _editContactScreen(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditContactScreen(contact: widget.item,),
      ),
    ).then((_) => setState(() {}));
  }

  void _addMeetingPointScreen(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddMeetingPointScreen(contact: widget.item,),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.item.nome,), 
        actions: [
          ElevatedButton(
            onPressed: () {
              _editContactScreen();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Icon(Icons.edit),
          ),
          ElevatedButton(
            onPressed: () {
              _addMeetingPointScreen();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Icon(Icons.add_location_alt),
          ),
        ]
      ),
      body: Center(
        child: Text(
          "You selected: ${widget.item.nome}",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

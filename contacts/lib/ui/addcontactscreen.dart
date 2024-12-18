import 'package:contacts/model/Contact.dart';
import 'package:contacts/model/contactsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';*/

class AddContactScreen extends StatelessWidget {
  final ContactList contactos;

  const AddContactScreen({super.key, required this.contactos});

  @override
  Widget build(BuildContext context) {
    return ContactForm(contactos: contactos);
  }
}

class ContactForm extends StatefulWidget {
  final ContactList contactos;

  const ContactForm({super.key, required this.contactos});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  DateTime? _selectedDate;
  bool isAniversario = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /*Future<void> pickImage() async {
  // Request permission to access the gallery
    var status = await Permission.photos.request();

    if (status.isGranted) {
      // If permission is granted, pick an image
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // Do something with the selected image
        File imgFile = File(image.path);
        //print('Image Path: ${imgFile.path}');
      }
    } else if (status.isDenied) {
      // If permission is denied, you can show a dialog or a message
      _notifyUser("Não será possivel selecionar imagens do dispositivo", "Permissão negada!");
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, open app settings
      openAppSettings();
    }
  }*/


  void _notifyUser(String message, String t) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _backToMain(){
    Navigator.pop(context);
  }

  void _addContact(ContactList contacts){
    if(_nameController.text.isEmpty){
      _notifyUser("O parâmetro Nome é obrigatório", "Não foi possível guardar o contacto!");
      return;
    }
    if(_emailController.text.isEmpty){
      _notifyUser("O parâmetro Email é obrigatório", "Não foi possível guardar o contacto!");
      return;
    }
    if(_phoneController.text.isEmpty){
      _notifyUser("O parâmetro Telemóvel é obrigatório", "Não foi possível guardar o contacto!");
      return;
    }
    if(_selectedDate == null && isAniversario){
      _notifyUser("Aniversário selecionado mas não inserido", "Não foi possível guardar o contacto!");
      return;
    }
    if(isAniversario){
      contacts.addContact(Contact(_nameController.text, _emailController.text, int.parse(_phoneController.text),"${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"));
    }
    else{
      contacts.addContact(Contact(_nameController.text, _emailController.text, int.parse(_phoneController.text),"--/--/----"));
    }
    _backToMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Contactos',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _addContact(widget.contactos);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              foregroundColor: Colors.black,
            ),
            child: const Row(
              children: [
                Text('Guardar contacto'),
                Icon(Icons.check),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nome:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Email:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Telemóvel:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, //Para ter a certeza que é um numero
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Switch(
                    value: isAniversario,
                    onChanged: (bool value) {
                      setState(() {
                        isAniversario = value;
                      });
                    },
                  ),
                  const Text(
                    'Aniversário:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                ]
              ),

              if (isAniversario)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selecione uma data',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _selectedDate == null
                                ? 'DD/MM/YYYY'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            style: const TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today, size: 32),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        //pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            child: Text('Selecionar fotografia'),
                          ),
                          Icon(Icons.image),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        // Take photo functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.black,
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FittedBox(
                            child: Text('Tirar fotografia'),
                          ),
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:contacts/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class AddMeetingPointScreen extends StatelessWidget {
  final Contact contact;

  const AddMeetingPointScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return _AddMeeting(contact: contact);
  }
}

class _AddMeeting extends StatefulWidget {
   final Contact contact;

  const _AddMeeting({super.key, required this.contact});

  @override
  State<_AddMeeting> createState() => _Details();
}

class _Details extends State<_AddMeeting> {
  late final TextEditingController _latController = TextEditingController();
  late final TextEditingController _longController = TextEditingController();

  final mapController = MapController();

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    userAgentPackageName: 'dev.fleaflet_map.example',
  );

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

  void _addPoint(){
    if(_latController.text.isEmpty){
      _notifyUser("O parâmetro Latitude não está preenchido", "Não foi possível guardar a localização!");
      return;
    }
    if(_longController.text.isEmpty){
      _notifyUser("O parâmetro Longitude não está preenchido", "Não foi possível guardar a localização!");
      return;
    }
    mapController.move(LatLng(double.parse(_latController.text), double.parse(_longController.text)), 12.0);

    widget.contact.addMeetingPoint(
      Marker(point: LatLng(double.parse(_latController.text), double.parse(_longController.text)), child: const Icon(Icons.location_pin, color: Colors.red,))
    );
    _notifyUser("", "Localização guardada!");
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          ElevatedButton(
            onPressed: () {
              _addPoint();
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            foregroundColor: Colors.black,
            ),
            child: const Row(
              children: [
                Text('Adicionar localização'),
                Icon(Icons.location_pin),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Latitude:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _latController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Longitude:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _longController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: FlutterMap(options: const MapOptions(
                  initialCenter: LatLng(40.1925,-8.4128),
                  initialZoom: 10,
                  interactionOptions: InteractionOptions(flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom),
                ),
                mapController: mapController,
                children: [
                  openStreetMapTileLayer,
                  if(widget.contact.meetingpoints.isNotEmpty)
                    MarkerLayer(markers: widget.contact.meetingpoints),
                ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

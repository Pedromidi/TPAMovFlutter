import 'package:contacts/model/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';


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

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    userAgentPackageName: 'dev.fleaflet_map.example',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Adicionar localização",), 
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
              /*ElevatedButton(
                onPressed: ,
                child: const Text('Get location'),
              ),*/
              SizedBox(
                height: 500,
                child: FlutterMap(options: const MapOptions(
                  initialCenter: LatLng(40.1925,-8.4128),
                  initialZoom: 10,
                  //interactionOptions: InteractionOptions(flags: InteractiveFlag.doubleTapZoom)
                ), 
                children: [
                  openStreetMapTileLayer,
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

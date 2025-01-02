import 'package:contacts/model/Contact.dart';
import 'package:contacts/ui/addmeetingpoint.dart';
import 'package:contacts/ui/editcontact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  final mapController = MapController();

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    userAgentPackageName: 'dev.fleaflet_map.example',
  );

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
          const SizedBox(width: 8),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: widget.item.picture,
                ),
                const SizedBox( width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Telemóvel: ${widget.item.phone}"),
                    Text("Email: ${widget.item.email}"),
                    Text("Aniversário: ${widget.item.getBday()}"),
                  ],
                ),
              ] 
            )
          ),
          Expanded(
            child: FlutterMap(options: const MapOptions(
                initialCenter: LatLng(40.1925,-8.4128),
                initialZoom: 10,
                interactionOptions: InteractionOptions(flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom),
              ),
              mapController: mapController,
              children: [
                Text("Telemóvel: ${widget.item.phone}\nEmail: ${widget.item.email}"),
                if(widget.item.birthdate?.day != null)
                  Text("Aniversário: ${widget.item.birthdate!.day}/${widget.item.birthdate!.month}/${widget.item.birthdate!.year}"),
                openStreetMapTileLayer,
                if(widget.item.meetingpoints.isNotEmpty)
                  MarkerLayer(markers: widget.item.meetingpoints),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

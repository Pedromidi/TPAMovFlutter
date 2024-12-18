import 'package:flutter/material.dart';

class LastTenEditedScreen extends StatefulWidget {
  const LastTenEditedScreen({super.key,});

  static const String routeName = "/ThirdScreen";

  @override
  State<LastTenEditedScreen> createState() => _LastTen();
}

class _LastTen extends State<LastTenEditedScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ultimos Contactos Alterados"), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sem ultimos contactos registados"),
            ElevatedButton(onPressed: (){}, child: const Text("Return")),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import "package:flutter_stakes/screens/productos_screens.dart";
import 'package:flutter_stakes/screens/mision_screen.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi app', style: TextStyle(color: Colors.black, fontSize: 30),),
        backgroundColor: Colors.tealAccent,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Home'),
            subtitle: Text('Inicio de la application'),
            leading: Icon(Icons.home, color: Colors.tealAccent),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
          ListTile(
            title: const Text("Mission"),
            subtitle: const Text('Who Are'),
            leading: const Icon(Icons.book, color: Colors.tealAccent),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {//Abrir otra screen
              final route = MaterialPageRoute(
                builder: (context) => const MisionScreen() );
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Productos'),
            subtitle: const Text('Nusestros productos'),
            leading: const Icon(Icons.card_travel, color: Colors.tealAccent),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {//Abrir otra screen
              final route = MaterialPageRoute(
                builder: (context) => const ProductosScreen() );
              Navigator.push(context, route);
            }
          ),
          const ListTile(
            title: Text('Contacto'),
            subtitle: Text('¿Dónde estamos?'),
            leading: Icon(Icons.phone, color: Colors.tealAccent),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          )
        ],
      ),
    );
  }
}
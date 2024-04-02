import 'package:flutter/material.dart';
import 'package:app_clientes_final/sebas_screen.dart';
import 'package:app_clientes_final/login_screen.dart';

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
            title: Text('Clientes'),
            subtitle: Text('Informacion de Clientes'),
            leading: Icon(Icons.home, color: Colors.tealAccent),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
          ListTile(
            title: const Text(' Ventas'),
            subtitle: const Text('Informacion de Ventas'),
            leading: const Icon(Icons.book, color: Colors.tealAccent),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {//Abrir otra screen
              final route = MaterialPageRoute(
                builder: (context) => const MisionScreen() );
              Navigator.push(context, route);
            },
          ),
         
        ],
        
      ),
       bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                '© Derechos de autor Sebastian Castaño Zuleta 2024',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
    );
  }
}
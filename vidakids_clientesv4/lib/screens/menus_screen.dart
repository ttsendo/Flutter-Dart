import 'package:flutter/material.dart';
import 'package:vidakids_clientesv4/screens/AgregarCliente_screen.dart';
import 'package:vidakids_clientesv4/screens/AgregarVenta_screen.dart';
import 'package:vidakids_clientesv4/screens/ListarCliente_screen.dart';
import 'package:vidakids_clientesv4/screens/ListarVenta_screen.dart';

// import 'package:vidakids_clientesv4/screens/ListarCliente_screen.dart';
import 'package:vidakids_clientesv4/screens/login_screen.dart';
// import 'package:vidakids_clientesv4/screens/AgregarCliente_screen.dart';


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
        title: const Text(
          'Ventas VidaKids',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 46, 50, 247),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => const Login() );
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
           ListTile(
            title: const Text('Clientes'),
            subtitle: const Text('Agregar Cliente.'),
            leading: const Icon(Icons.add_outlined, color: Color.fromARGB(255, 46, 50, 247)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              final route = MaterialPageRoute(
                builder: (context) =>  AgregarCliente() );
              Navigator.push(context, route);
            }
          ),
          ListTile(
            title: const Text('Listado Clientes'),
            subtitle: const Text('tabla'),
            leading: const Icon(Icons.person_2_outlined, color: Color.fromARGB(255, 46, 50, 247)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: (){
              final route = MaterialPageRoute(
                builder: (context) => const ListarClientes());
              Navigator.push(context, route);
            },
          ),
            ListTile(
            title: const Text('Agregar Venta'),
            subtitle: const Text('Agrega una nueva venta'),
            leading: const Icon(Icons.person_2_outlined, color: Color.fromARGB(255, 46, 50, 247)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: (){
              final route = MaterialPageRoute(
                builder: (context) =>  AgregarVenta());
              Navigator.push(context, route);
            },
          ),
            ListTile(
            title: const Text('Listado Ventas'),
            subtitle: const Text('Ve el listado de las ventas'),
            leading: const Icon(Icons.person_2_outlined, color: Color.fromARGB(255, 46, 50, 247)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: (){
              final route = MaterialPageRoute(
                builder: (context) => const ListarVentas());
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
                '© Derechos de autor Sebastìan Castaño Z 2024',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
    );
  }
}

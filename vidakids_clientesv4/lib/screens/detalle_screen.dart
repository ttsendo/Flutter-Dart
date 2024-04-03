
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vidakids_clientesv4/screens/ListarCliente_screen.dart';

class DetalleClienteScreen extends StatefulWidget {
  
  final String nombre;
  final String apellido;
  final String email;
  final int telefono;
  final String ciudad;
  final String password;
  const DetalleClienteScreen({
    super.key,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.ciudad,
    required this.password, required String id,
  });
  @override
  State<DetalleClienteScreen> createState() => _DetalleClienteScreenState();
}

class _DetalleClienteScreenState extends State<DetalleClienteScreen> {
    final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
   final _ciudadController = TextEditingController();
  final _passwordController = TextEditingController();

    void updateCliente() async {
    final response = await http.put(
      Uri.parse('https://clienteslote2.onrender.com/clientes'),
      body: {
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'email': _emailController.text,
        'telefono': _telefonoController.text,
        "ciudad": _ciudadController.text,
        'password': _passwordController.text
        ,
      },
    );
    if (response.statusCode == 200) {
      // Refresh the list of clientes
      setState(() {});
    } else {
      throw Exception('Failed to update cliente: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Cliente ${widget.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.nombre,
              decoration: InputDecoration(labelText: 'Nombre', hintText: widget.nombre, ),
            ),
            TextFormField(
              initialValue: widget.apellido,
              decoration: InputDecoration(labelText: 'Apellido', hintText: widget.apellido),
            ),
            TextFormField(
              initialValue: widget.email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              initialValue: widget.telefono.toString(),
              decoration: InputDecoration(labelText: 'Teléfono' , hintText: widget.telefono.toString()),
            ),
               TextFormField(
              initialValue: widget.ciudad.toString(),
              decoration: InputDecoration(labelText: 'Ciudad' , hintText: widget.ciudad.toString()),
            ),
            TextFormField(
              initialValue: widget.password,
              decoration: InputDecoration(labelText: 'Contraseña', hintText: widget.password),
            ),
            ElevatedButton(
              onPressed: () {
                // Enviar los cambios y actualizar el cliente
                MaterialPageRoute(builder: (context) => const ListarClientes());
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
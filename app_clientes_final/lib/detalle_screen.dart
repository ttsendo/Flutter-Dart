import 'package:app_clientes_final/sebas_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetalleClienteScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String email;
  final int telefono;
  final String password;
  const DetalleClienteScreen({
    super.key,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
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
  final _passwordController = TextEditingController();

    void updateCliente() async {
    final response = await http.put(
      Uri.parse('https://backendapiclientesv2.onrender.com/cliente'),
      body: {
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'email': _emailController.text,
        'telefono': _telefonoController.text,
        'password': _passwordController.text,
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
              initialValue: widget.password,
              decoration: InputDecoration(labelText: 'Contraseña', hintText: widget.password),
            ),
            ElevatedButton(
              onPressed: () {
                // Enviar los cambios y actualizar el cliente
                MaterialPageRoute(builder: (context) => const ClienteScreen());
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
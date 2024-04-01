
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class EditarClienteScreen extends StatefulWidget {
  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final int telefono;
  final String password;

  const EditarClienteScreen({
    super.key,
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.password,
  });
  @override
  State<EditarClienteScreen> createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  void updateCliente(Map<String, dynamic> cliente, String id) async {
    final response = await http.put(
      Uri.parse('https://backendapiclientesv2.onrender.com/cliente/?id=$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cliente),
    );
    if (response.statusCode == 200) {
      // Refresh the list of clientes
      setState(() {});
      //Regresamos a la pantalla anterior

    } else {
      throw Exception('Failed to update cliente: ${response.statusCode}');
    }
  }
  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.nombre;
    _apellidoController.text = widget.apellido;
    _emailController.text = widget.email;
    _telefonoController.text = widget.telefono.toString();
    _passwordController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Cliente ${widget.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre', hintText: widget.nombre),
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido', hintText: widget.apellido),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email', hintText: widget.email),
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono' , hintText: widget.telefono.toString()),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña', hintText: widget.password),
            ),
            ElevatedButton(
              //Parseamos el telefono a entero
              onPressed: () {
                var id = widget.id;
                var telefono = int.parse(_telefonoController.text);
                var cliente = {
                  'nombre': _nombreController.text,
                  'apellido': _apellidoController.text,
                  'email': _emailController.text,
                  'telefono':telefono,
                  'password': _passwordController.text,
                };
                updateCliente(cliente, id
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
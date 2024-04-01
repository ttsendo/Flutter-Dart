import 'dart:convert';
import 'package:app_clientes_final/sebas_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//package:http/http.dart
class CrearCliente extends StatefulWidget {
  const CrearCliente({super.key});

  @override
  State<CrearCliente> createState() => _CrearClienteState();
}

class _CrearClienteState extends State<CrearCliente> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _idController = TextEditingController();

  void registrarCliente(Map<String, dynamic> cliente) async {
    final response = await http.post(
      Uri.parse('https://backendapiclientesv2.onrender.com/cliente'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cliente),
    );

    if (response.statusCode == 200) {

    } else {
      print(response.statusCode); 
      throw Exception('Failed to register cliente: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.number, // Set keyboard type to number
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            ElevatedButton(
              onPressed: () async {
                var telefono = int.parse(_telefonoController.text);
                var cliente = {
                  'id': _idController.text,
                  'nombre': _nombreController.text,
                  'apellido': _apellidoController.text,
                  'email': _emailController.text,
                  'telefono': telefono,
                  'password': _passwordController.text,
                };
                 registrarCliente(cliente);
                //Redirigimos al listar
                MaterialPageRoute(builder: (context) => const ClienteScreen());
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
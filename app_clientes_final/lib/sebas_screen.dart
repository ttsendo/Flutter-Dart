import 'dart:convert';
import 'package:app_clientes_final/crear_sebas_screen.dart';
import 'package:app_clientes_final/detalle_screen.dart';
import 'package:app_clientes_final/editar_screen.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class Cliente {
  final String id;
  final String nombre;
  final String apellido;
  final String email;
  final int telefono;
  final String password;

  Cliente({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.password,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        email: json['email'],
        telefono: json['telefono'],
        password: json['password'],
      );

  Future<List<Cliente>> fetchClientes() async {
    final response = await http
        .get(Uri.parse('https://backendapiclientesv2.onrender.com/cliente'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['msg'] as List;
      return data.map((client) => Cliente.fromJson(client)).toList();
    } else {
      throw Exception('Failed to fetch clientes: ${response.statusCode}');
    }
  }
}

class _ClienteScreenState extends State<ClienteScreen> {
  void deleteCliente(String id) async {
    final response = await http.delete(
      Uri.parse('https://backendapiclientesv2.onrender.com/cliente/?id=$id'),
    );
    if (response.statusCode == 200) {
      // Refresh the list of clientes
      setState(() {});
    } else {
      throw Exception('Failed to delete cliente: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: FutureBuilder<List<Cliente>>(
        future: Cliente(
                id: '',
                nombre: '',
                apellido: '',
                email: '',
                telefono: 0,
                password: '')
            .fetchClientes(), // Fetch the
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final clientes = snapshot.data!;
            return ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];
                return ListTile(
                  title: Text('${cliente.nombre} ${cliente.apellido}'),
                  subtitle: Text(cliente.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarClienteScreen(
                                nombre: cliente.nombre,
                                apellido: cliente.apellido,
                                email: cliente.email,
                                telefono: cliente.telefono,
                                password: cliente.password, 
                                id: cliente.id,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Delete the cliente
                          deleteCliente(cliente.id);
                        },
                      ),
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleClienteScreen(
                                id: cliente.id,
                                nombre: cliente.nombre,
                                apellido: cliente.apellido,
                                email: cliente.email,
                                telefono: cliente.telefono,
                                password: cliente.password,
                              ),
                            ),
                          );
                      }, icon: const Icon(Icons.remove_red_eye_outlined))
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Show a loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        },
      ),
      //Botón para agregar un nuevo cliente
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearCliente(
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

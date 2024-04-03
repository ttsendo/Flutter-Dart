
import 'package:flutter/material.dart';
import 'package:vidakids_clientesv4/screens/EditarCliente_screen.dart';
import 'package:vidakids_clientesv4/screens/detalle_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cliente {
  final String idC;
  final String nombre;
  final String apellido;
  final String email;
  final int telefono;
  final String ciudad;
  final String password;

  Cliente({
    required this.idC,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.ciudad,
    required this.password,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idC: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      telefono: json['telefono'],
      ciudad: json['ciudad'] ?? '' ,
      password: json['password'],
    );
  }
}

Future<List<Cliente>> fetchPost() async {
  final response = await http.get(Uri.parse("https://clienteslote2.onrender.com/clientes"));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> clientesJson = jsonData['msg'];
    return clientesJson.map((json) => Cliente.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de los clientes');
  }
}

class ListarClientes extends StatefulWidget {
  const ListarClientes({Key? key}) : super(key: key);

  @override
  State<ListarClientes> createState() => _ListarClientesState();
}

class _ListarClientesState extends State<ListarClientes> {
  late List<Cliente> clientes;

  @override
  void initState() {
    super.initState();
    clientes = [];
  }

  void editarCliente(BuildContext context, Cliente cliente) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarCliente(cliente: cliente),
      ),
    );

    if (result != null && result is bool && result) {
      setState(() {
        int index = clientes.indexWhere((e) => e.idC == cliente.idC);
        if (index != -1) {
          clientes[index] = cliente;
        }
      });
    }
  }

  Future<void> eliminarCliente(String idC) async {
    final response = await http.delete(
      Uri.parse("https://clienteslote2.onrender.com/clientes/$idC"),
    );
    if (response.statusCode == 200) {
      print('Cliente eliminado exitosamente');
      setState(() {
        clientes.removeWhere((e) => e.idC == idC);
      });
    } else {
      print('Error al eliminar el cliente: ${response.statusCode}');
    }
  }

  void verDetalleCliente(BuildContext context, Cliente cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleClienteScreen(
          id: cliente.idC,
          nombre: cliente.nombre,
          apellido: cliente.apellido,
          email: cliente.email,
          telefono: cliente.telefono,
          ciudad: cliente.ciudad,
          password: cliente.password,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Clientes"),
      ),
      body: FutureBuilder(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          List<Cliente> clientes = snapshot.data as List<Cliente>;
          return ListView.builder(
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(clientes[index].nombre),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(clientes[index].apellido),
                    Text(clientes[index].email),
                    Text(clientes[index].telefono.toString()),
                    Text(clientes[index].ciudad),
                    Text(clientes[index].password),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editarCliente(context, clientes[index]);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        bool confirmacion = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar eliminación'),
                              content: const Text(
                                  '¿Estás seguro de que deseas eliminar este Cliente?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmacion == true) {
                          eliminarCliente(clientes[index].idC);
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        verDetalleCliente(context, clientes[index]);
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ],
                ),
              );
            },
          );
        },

      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Center(
            child: Text(
              '© © Todos los derechos reservados VidaKids',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

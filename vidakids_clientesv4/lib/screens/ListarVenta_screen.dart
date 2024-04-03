
import 'package:flutter/material.dart';
import 'package:vidakids_clientesv4/screens/detalleVenta_screen.dart';
import 'package:vidakids_clientesv4/screens/EditarVenta_screen.dart';
import 'dart:convert';
import 'package:vidakids_clientesv4/screens/AgregarVenta_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Venta {
  final String idVenta;
  final String nombreProducto;
  final String precioProducto;


  Venta({
    required this.idVenta,
    required this.nombreProducto,
    required this.precioProducto,

  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      idVenta: json['id_venta'],
      nombreProducto: json['nombre_producto'],
      precioProducto: json['precio_producto'],
    );
  }
}

Future<List<Venta>> fetchPost() async {
  final response = await http.get(Uri.parse("https://clienteslote2.onrender.com/ventas"));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final List<dynamic> ventasJson = jsonData['msg'];
    return ventasJson.map((json) => Venta.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de las Ventas');
  }
}

class ListarVentas extends StatefulWidget {
  const ListarVentas({Key? key}) : super(key: key);

  @override
  State<ListarVentas> createState() => _ListarVentasState();
}

class _ListarVentasState extends State<ListarVentas> {
  late List<Venta> ventas;

  @override
  void initState() {
    super.initState();
    ventas = [];
  }

  void editarVenta(BuildContext context, Venta venta) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarVenta(venta: venta),
      ),
    );

    if (result != null && result is bool && result) {
      setState(() {
        int index = ventas.indexWhere((e) => e.idVenta == venta.idVenta);
        if (index != -1) {
          ventas[index] = venta;
        }
      });
    }
  }

  Future<void> eliminarVenta(String idVenta) async {
    final response = await http.delete(
      Uri.parse("https://clienteslote2.onrender.com/ventas/$idVenta"),
    );
    if (response.statusCode == 200) {
      print('Venta eliminada exitosamente');
      setState(() {
        ventas.removeWhere((e) => e.idVenta == idVenta);
      });
    } else {
      print('Error al eliminar la venta: ${response.statusCode}');
    }
  }

  void verDetalleVenta(BuildContext context, Venta venta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleVentaScreen(
          idVenta : venta.idVenta,
          nombreProducto: venta.nombreProducto,
          precioProducto: venta.precioProducto,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Ventas"),
      ),
      body: FutureBuilder(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          List<Venta> ventas = snapshot.data as List<Venta>;
          return ListView.builder(
            itemCount: ventas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ventas[index].nombreProducto),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ventas[index].precioProducto),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        editarVenta(context, ventas[index]);
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
                                  '¿Estás seguro de que deseas eliminar esta Venta?'),
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
                          eliminarVenta(ventas[index].idVenta);
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        verDetalleVenta(context, ventas[index]);
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
              '© Derechos de autor Sebastìan Castaño Z 2024',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

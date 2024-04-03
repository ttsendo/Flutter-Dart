import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vidakids_clientesv4/screens/ListarVenta_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditarVenta extends StatefulWidget {
  final Venta venta;

  const EditarVenta({required this.venta});

  @override
  _EditarVentaState createState() => _EditarVentaState();
}

class _EditarVentaState extends State<EditarVenta> {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  late TextEditingController idVenta;
  late TextEditingController nombreProducto;
  late TextEditingController precioProducto;

  @override
  void initState() {
    super.initState();
    idVenta = TextEditingController(text: widget.venta.idVenta);
    nombreProducto = TextEditingController(text: widget.venta.nombreProducto);
    precioProducto = TextEditingController(text: widget.venta.precioProducto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Venta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formLogin,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType:TextInputType.number,
                    controller: idVenta,
                    decoration: const InputDecoration(
                        hintText: "id Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el id de la venta',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el id ";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: nombreProducto,
                    decoration: const InputDecoration(
                        hintText: "Nombre del Producto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el nombre del Producto',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el nombre del Producto";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: precioProducto,
                    decoration: const InputDecoration(
                        hintText: "Precio del Producto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el precio del Producto',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el Precio";
                      }
                      return null;
                    }),
                
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formLogin.currentState!.validate()) {
                      _formLogin.currentState!.save();
                      String nuevoIdVenta = idVenta.text;
                      String nuevoNombreProducto = nombreProducto.text;
                      String nuevoPrecioProducto = precioProducto.text;

                      Map<String, dynamic> cuerpoSolicitud = {
                        "id_venta": nuevoIdVenta,
                        "nombre_producto": nuevoNombreProducto,
                        "precio_producto": nuevoPrecioProducto,
                      };

                   
                      http.put(
                        Uri.parse(
                            "https://clienteslote2.onrender.com/ventas/${widget.venta.idVenta}"),
                        body: jsonEncode(cuerpoSolicitud),
                        headers: {
                          "Content-Type": "application/json"
                        }, // Establece el tipo de contenido como JSON
                      ).then((response) {
                        if (response.statusCode == 200) {
                          print("La venta fue actualizada con éxito");
                          Navigator.pop(context, true);
                        } else {
                          print(
                              "Hubo un error al actualizar la Venta: ${response.statusCode}");
                        }
                      }).catchError((error) {
                        print("Error al realizar la solicitud HTTP: $error");
                      });
                    }
                  },
                  child: const Text('Actualizar Venta'),
                ),
              ],
            ),
          ),
        ),
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

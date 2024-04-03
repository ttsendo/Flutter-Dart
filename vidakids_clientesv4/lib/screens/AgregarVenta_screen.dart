import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidakids_clientesv4/screens/ListarVenta_screen.dart';

class Http {
  static String url = "https://clienteslote2.onrender.com/ventas";

  static postVenta(Map venta) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(venta),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Falló la inserción contacta con el administrador del sistema");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class AgregarVenta extends StatelessWidget {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  final TextEditingController id_venta = TextEditingController();
  final TextEditingController nombre_producto = TextEditingController();
  final TextEditingController precio_producto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar una Venta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formLogin,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    controller: id_venta,
                    decoration: const InputDecoration(
                        hintText: "id de la Venta",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el id',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el id";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: nombre_producto,
                    decoration: const InputDecoration(
                        hintText: "Nombre del producto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite nombre del Producto',
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
                    controller: precio_producto,
                    decoration: const InputDecoration(
                        hintText: "precio del producto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el Precio del Producto',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el precio";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (_formLogin.currentState!.validate()) {
                      _formLogin.currentState!.save();
                      var venta = {
                        "id_venta": id_venta.text,
                        "nombre_producto": nombre_producto.text,
                        "precio_producto": precio_producto.text,
                      };

                      print(venta);
                      Http.postVenta(venta).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListarVentas(),
                          ),
                        );
                      });
                    }
                  },
                  icon: const Icon(Icons.add_outlined),
                  label: const Text('Registrar Venta',
                      style: TextStyle(color: Colors.white)),
                )
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

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidakids_clientesv4/screens/ListarCliente_screen.dart';

class Http {
  static String url = "https://clienteslote2.onrender.com/clientes";

  static postCliente(Map cliente) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(cliente),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print(
            "Falló la inserción contacta con el administrador del sistema");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class AgregarCliente extends StatelessWidget {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  final TextEditingController id = TextEditingController();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController apellido = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController telefono = TextEditingController();
  final TextEditingController ciudad = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar un Cliente'),
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
                    controller: id,
                    decoration: const InputDecoration(
                        hintText: "id del Cliente",
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
                    controller: nombre,
                    decoration: const InputDecoration(
                        hintText: "Nombre del Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite nombre del Cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el nombre del Cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: apellido,
                    decoration: const InputDecoration(
                        hintText: "Apellido del Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el Apellido del Cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el Apellido";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                        hintText: "Correo del Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el Correo del Cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el Correo del Cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: telefono,
                    decoration: const InputDecoration(
                        hintText: "Telefono de Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el Telefono Del Cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el Telefono del Cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: ciudad,
                    decoration: const InputDecoration(
                        hintText: "Ciudad ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText:
                            'Digite la Ciudad que usara el Clietne',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese la Ciudad";
                      }
                      return null;
                    }),
                    TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                        hintText: "Contraseña del Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText:
                            'Digite la Contraseña que usara el Clietne',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese la Contraseña";
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
                      var cliente = {
                        "id": id.text,
                        "nombre": nombre.text,
                        "apellido": apellido.text,
                        "email": email.text,
                        "telefono": telefono.text,
                        "ciudad" : ciudad.text,
                        "password": password.text,
                      };

                      print(cliente);
                      Http.postCliente(cliente).then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListarClientes(),
                          ),
                        );
                      });
                    }
                  },
                  icon: const Icon(Icons.add_outlined),
                  label: const Text('Registrar Cliente',
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
              '© Todos los derechos reservados VidaKids',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}

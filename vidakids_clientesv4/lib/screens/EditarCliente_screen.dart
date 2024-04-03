import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:vidakids_clientesv4/screens/ListarCliente_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditarCliente extends StatefulWidget {
  final Cliente cliente;

  const EditarCliente({required this.cliente});

  @override
  _EditarClienteState createState() => _EditarClienteState();
}

class _EditarClienteState extends State<EditarCliente> {
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  late TextEditingController idC;
  late TextEditingController nombre;
  late TextEditingController apellido;
  late TextEditingController email;
  late TextEditingController telefono;
  late TextEditingController ciudad;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    idC = TextEditingController(text: widget.cliente.idC);
    nombre = TextEditingController(text: widget.cliente.nombre);
    apellido = TextEditingController(text: widget.cliente.apellido);
    email = TextEditingController(text: widget.cliente.email);
    telefono = TextEditingController(text: widget.cliente.telefono.toString());
    ciudad = TextEditingController(text: widget.cliente.ciudad);
    password = TextEditingController(text: widget.cliente.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
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
                    controller: idC,
                    decoration: const InputDecoration(
                        hintText: "id Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el id de cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el id del cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: nombre,
                    decoration: const InputDecoration(
                        hintText: "Nombre Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el nombre del Cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el nombre del cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: apellido,
                    decoration: const InputDecoration(
                        hintText: "Apellido Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el apellido del cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el apellido";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType:TextInputType.emailAddress,
                    controller: email,
                    decoration: const InputDecoration(
                        hintText: "Email Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el email del cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese elemail del cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    keyboardType: TextInputType.number,
                    controller: telefono,
                    decoration: const InputDecoration(
                        hintText: "Telefono Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite el numero de telefono del cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese el telefono del cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: ciudad,
                    decoration: const InputDecoration(
                        hintText: "Ciudad Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite la Ciudad del cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese la ciudad del cliente";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                        hintText: "Contraseña Cliente",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Digite la contraseña del cliente',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: AutofillHints.name)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor ingrese la contraseña del cliente";
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formLogin.currentState!.validate()) {
                      _formLogin.currentState!.save();
                      String nuevoIdCliente = idC.text;
                      String nuevoNombreCliente = nombre.text;
                      String nuevoApellidoCliente = apellido.text;
                      String nuevoEmailCliente = email.text;
                      int nuevoTelefonoCliente = int.parse(telefono.text);
                      String nuevoCiudadCliente = ciudad.text;
                      String nuevaPasswordCliente = password.text;

                      Map<String, dynamic> cuerpoSolicitud = {
                        "id": nuevoIdCliente,
                        "nombre": nuevoNombreCliente,
                        "apellido": nuevoApellidoCliente,
                        "email": nuevoEmailCliente,
                        "telefono": nuevoTelefonoCliente,
                        "ciudad": nuevoCiudadCliente,
                        "password": nuevaPasswordCliente,
                      };

                   
                      http.put(
                        Uri.parse(
                            "https://clienteslote2.onrender.com/clientes/${widget.cliente.idC}"),
                        body: jsonEncode(cuerpoSolicitud),
                        headers: {
                          "Content-Type": "application/json"
                        }, // Establece el tipo de contenido como JSON
                      ).then((response) {
                        if (response.statusCode == 200) {
                          print("El cliente fue actualizado con éxito");
                          Navigator.pop(context, true);
                        } else {
                          print(
                              "Hubo un error al actualizar el cliente: ${response.statusCode}");
                        }
                      }).catchError((error) {
                        print("Error al realizar la solicitud HTTP: $error");
                      });
                    }
                  },
                  child: const Text('Actualizar Cliente'),
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

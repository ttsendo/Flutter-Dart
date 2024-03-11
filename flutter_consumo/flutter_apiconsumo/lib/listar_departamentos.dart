import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//https://www.datos.gov.co/resource/vcjz-niiq.json

class Departamento {
  // ignore: non_constant_identifier_names
  final String codigo_departamento;
  // ignore: non_constant_identifier_names
  final String nombre_departamento;

  Departamento(
      {required this.codigo_departamento, required this.nombre_departamento});

  factory Departamento.fromJson(Map<String, dynamic> json) {
    return Departamento(
        codigo_departamento: json['codigo_departamento'],
        nombre_departamento: json['nombre_departamento']);
  }
}

Future<List<Departamento>>fetchPost() async {
  final response = await http.get(Uri.parse("https://www.datos.gov.co/resource/vcjz-niiq.json"));
  if(response.statusCode == 200){
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Departamento.fromJson(json)).toList();

  }else{
    throw Exception('Fallo la carga de los departamentos');
  }
}

class ListarDepartamentos extends StatefulWidget {
  const ListarDepartamentos({super.key});

  @override
  State<ListarDepartamentos> createState() => _ListarDepartamentosState();
}

class _ListarDepartamentosState extends State<ListarDepartamentos> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Listar departamentos"),
      ),
      body: FutureBuilder(
      future: fetchPost(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){ 
          return const Text('Error');
        }
        List<Departamento> departamentos = snapshot.data as List<Departamento>;
        return ListView.builder(
          itemCount: departamentos.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(departamentos[index].codigo_departamento),
              subtitle: Text(departamentos[index].nombre_departamento),
            );
          }
        );
      },
        ),
    );
  }
}
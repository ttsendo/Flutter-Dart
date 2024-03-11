
import 'package:flutter/material.dart';
import 'package:flutter_apiconsumo/listar_departamentos.dart';
import 'package:flutter_apiconsumo/listar_hurtos.dart';

void main(){
  runApp(const Main());
}
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _nameState();
}

class _nameState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: ListarDepartamentos(),
      home: ListarHurtos(),
    );
  }
}
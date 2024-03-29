import 'dart:convert';

import 'package:flutter/material.dart';


class clientes extends StatefulWidget {
  const clientes({super.key});

  @override
  State<clientes> createState() => _clientesState();
}

class _clientesState extends State<clientes> {
  void add (){

  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar una Venta",style: TextStyle(color: Colors.black, fontSize: 30),),
        backgroundColor: Colors.tealAccent,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.add_box, color:  Color.fromARGB(255, 100, 231, 104),),
                  hintText: "Nombre producto",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Digite el nombre del producto',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15,fontFamily: AutofillHints.username)
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.numbers_sharp, color:  Color.fromARGB(255, 100, 231, 104),),
                  suffixIcon: Icon(Icons.numbers, color:  Color.fromARGB(255, 100, 231, 104),),
                  hintText: "Cantidad",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: 'Digitar cantidad',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15,fontFamily: AutofillHints.password)
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),
                onPressed: add,
                 icon: const Icon(Icons.add), label: const Text('Agregar', selectionColor: Colors.white,),)
            ],
          ),
        ),
        ),
    );
  }
}
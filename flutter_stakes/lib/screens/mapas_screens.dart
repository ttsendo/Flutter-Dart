import 'package:flutter/material.dart';
class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

Map ventas = {
    'referencia': ['SDA1231', 'ASDJA23', 'BRJ23I4', 'GJITKR2', 'SDFDKEW'],
    'nombre': ['Arroz', 'Panela', 'Huevo', 'Arepa', 'Atún'],
    'precio':  [3200, 2500, 600, 1800, 4300]
  
};

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa recorrido"),
      ),
      body: ListView.builder(
        itemCount: ventas['nombre'].length,
        itemBuilder: (BuildContext context, index){
          return ListTile( 
            title: Text(ventas['nombre'][index]),
            subtitle: Text("Referecia: ${ventas['referencia'][index]}\nPrecio: ${ventas['precio'][index]}"),
          );
        }
      ),
    );
  }
}




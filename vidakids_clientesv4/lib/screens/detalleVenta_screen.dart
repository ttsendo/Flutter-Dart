
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vidakids_clientesv4/screens/ListarVenta_screen.dart';

class DetalleVentaScreen extends StatefulWidget {
  
  final String nombreProducto;
  final String precioProducto;
  const DetalleVentaScreen({
    super.key,
    required this.nombreProducto,
    required this.precioProducto , required String idVenta

  });
  @override
  State<DetalleVentaScreen> createState() => _DetalleVentaScreenState();
}

class _DetalleVentaScreenState extends State<DetalleVentaScreen> {
    final _nombreProductoController = TextEditingController();
  final _precioProductoController = TextEditingController();


    void updateCliente() async {
    final response = await http.put(
      Uri.parse('https://clienteslote2.onrender.com/clientes'),
      body: {
        'nombre_producto': _nombreProductoController.text,
        'precio_producto': _precioProductoController.text,
      },
    );
    if (response.statusCode == 200) {
      // Refresh the list of clientes
      setState(() {});
    } else {
      throw Exception('Failed to update venta: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Venta ${widget.nombreProducto}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.nombreProducto,
              decoration: InputDecoration(labelText: 'Producto', hintText: widget.nombreProducto, ),
            ),
            TextFormField(
              initialValue: widget.precioProducto,
              decoration: InputDecoration(labelText: 'Preico', hintText: widget.precioProducto),
            ),
           
            ElevatedButton(
              onPressed: () {
                // Enviar los cambios y actualizar el cliente
                MaterialPageRoute(builder: (context) => const ListarVentas());
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
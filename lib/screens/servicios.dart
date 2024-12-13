import 'dart:convert';
import 'package:evaluacion_02/screens/citas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios Médicos"),
        backgroundColor: Color(0xFF00796B), // Verde, color típico para la salud
      ),
      drawer: _buildDrawer(context), // Aquí agregamos el Drawer
      body: listViewExterno("https://jritsqmet.github.io/web-api/medico.json"),
    );
  }

  // Función para construir el Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF00796B), // Color para el header
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context); // Cerrar el Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Crear Cita'),
            onTap: () {
              // Navegar a AppointmentScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppointmentScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_hospital),
            title: const Text('Servicios Médicos'),
            onTap: () {
              Navigator.pop(context); // Solo cerrar el Drawer
            },
          ),
        ],
      ),
    );
  }

  Future<List> jsonExterno(url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["servicio_medico"];
    } else {
      return throw Exception("Sin conexión");
    }
  }

  Widget listViewExterno(url) {
    return FutureBuilder(
      future: jsonExterno(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                elevation: 4, // Sombra para dar profundidad
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
                color: Color(0xFFF1F8E9), // Color suave de fondo
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    item['nombre'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF00796B), // Color verde para resaltar
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(child: Text(item['horario'], style: TextStyle(fontSize: 14))),
                    ],
                  ),
                  onTap: () {
                    // Mostrar el AlertDialog con los detalles del servicio
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(item['nombre'], style: TextStyle(fontSize: 20, color: Color(0xFF00796B))),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nombre: ${item['nombre']}', style: TextStyle(fontSize: 18)),
                                SizedBox(height: 8),
                                Text('Horario: ${item['horario']}', style: TextStyle(fontSize: 16)),
                                SizedBox(height: 8),
                                Text('Descripción: ${item['descripcion'] ?? "No disponible"}', style: TextStyle(fontSize: 16)),
                                SizedBox(height: 8),
                                // Si existe una imagen, la mostramos
                                if (item['imagen'] != null)
                                  Image.network(item['imagen'], height: 200, width: double.infinity, fit: BoxFit.cover),
                                SizedBox(height: 8),
                                // Text('Más detalles sobre este servicio...', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cerrar el diálogo
                              },
                              child: Text('Cerrar', style: TextStyle(color: Color(0xFF00796B))),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

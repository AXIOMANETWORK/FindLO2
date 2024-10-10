import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DirectorioScreen extends StatefulWidget {
  @override
  _DirectorioScreenState createState() => _DirectorioScreenState();
}

class _DirectorioScreenState extends State<DirectorioScreen> {
  // Función para mostrar el modal con la información del lugar
  void _showRestaurantModal(BuildContext context, Map<String, dynamic> restaurantData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permitir scroll si el contenido es más grande que la pantalla
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9, // Altura fija del 90% de la pantalla
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Márgenes para evitar que se desborde
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header del modal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        restaurantData['name'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Imagen del lugar
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    restaurantData['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25),

                // Información del lugar con margen adicional
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      children: [
                        Expanded(
                          child: Text(
                            restaurantData['info'],
                            style: TextStyle(fontSize: 16, height: 1.4), // Ajuste de altura de línea
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.redAccent),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                restaurantData['direccion'],
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, // Límite de líneas para evitar desbordes
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.blueAccent),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Horario: ${restaurantData['horario']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Teléfono: ${restaurantData['telefono']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.web, color: Colors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Web: ${restaurantData['web']}',
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 65, 81), // Color de fondo del AppBar
        elevation: 0, // Sin sombra en el AppBar
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('restaurants').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final restaurants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurantData = restaurants[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    restaurantData['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(restaurantData['direccion']),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showRestaurantModal(context, restaurantData);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
            padding: EdgeInsets.all(16.0),
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
                SizedBox(height: 35),

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

                // Información del lugar
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        restaurantData['info'],
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.redAccent),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(restaurantData['direccion']),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blueAccent),
                          SizedBox(width: 8),
                          Text('Horario: ${restaurantData['horario']}'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Teléfono: ${restaurantData['telefono']}'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.web, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text('Web: ${restaurantData['web']}'),
                          ),
                        ],
                      ),
                    ],
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

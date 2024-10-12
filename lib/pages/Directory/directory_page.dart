import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DirectorioScreen extends StatefulWidget {
  @override
  _DirectorioScreenState createState() => _DirectorioScreenState();
}

class _DirectorioScreenState extends State<DirectorioScreen> {

  // Función para determinar el ícono basado en el texto de la amenidad
  IconData getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wifi':
        return FontAwesomeIcons.wifi;
      case 'A/C':
        return FontAwesomeIcons.fan;
      case 'estacionamiento':
        return FontAwesomeIcons.squareParking;
      case 'restaurante':
        return FontAwesomeIcons.utensils;
      case 'piscina':
        return FontAwesomeIcons.waterLadder;
      case 'bar':
        return FontAwesomeIcons.beerMugEmpty;
      case 'gimnasio':
        return FontAwesomeIcons.dumbbell;
      default:
        return FontAwesomeIcons.circleInfo; // Ícono por defecto
    }
  }
  // Función para mostrar el modal con la información del lugar
  void _showRestaurantModal(BuildContext context, Map<String, dynamic> restaurantData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header con la categoría y botón de cerrar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          restaurantData['category'] ?? 'Categoría',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40), // Espacio para que la flecha y el texto estén alineados
                    ],
                  ),
                  SizedBox(height: 20),

                  // Imagen
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          restaurantData['image'],
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurantData['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange, size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    restaurantData['rating']?.toString() ?? 'N/A',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                  SizedBox(height: 20),

                  // Galería (si no está vacía)
                  if (restaurantData['gallery'] != null && restaurantData['gallery'].isNotEmpty) ...[
                    Text(
                      'Galería',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: restaurantData['gallery'].map<Widget>((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],

                  // Acerca de
                  Text(
                    'Acerca de',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    restaurantData['info'],
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                  SizedBox(height: 20),

                  // Características/Amenidades
                  Text(
                    'Amenidades',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: restaurantData['amenidades'].map<Widget>((amenity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            FaIcon(getAmenityIcon(amenity), color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              amenity,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Botón de promociones
                  ElevatedButton(
                    onPressed: () {
                      // Acción para el botón de promociones
                    },
                    child: Text('Promociones', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                  ),
                ],
              ),
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
        title: Text('Directorio', style: TextStyle(color: Colors.white),),
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

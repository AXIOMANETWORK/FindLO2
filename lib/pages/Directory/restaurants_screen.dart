import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantsScreen extends StatefulWidget {
  final String selectedCategory;
  final String displayName;

  const RestaurantsScreen({required this.selectedCategory, required this.displayName});

  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  // Función para determinar el ícono basado en el texto de la amenidad
  IconData getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wifi':
        return FontAwesomeIcons.wifi;
      case 'a/c':
        return Icons.air_sharp;
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
        final size = MediaQuery.of(context).size;
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
                              fontSize: size.width *0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width *0.1), // Espacio para que la flecha y el texto estén alineados
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),

                  // Imagen
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          restaurantData['image'],
                          height: size.height * 0.25,
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
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange, size: size.width * 0.06),
                                  SizedBox(width: size.width * 0.01),
                                  Text(
                                    restaurantData['rating']?.toString() ?? 'N/A',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width * 0.05,
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
                  SizedBox(height: size.height * 0.03),

                  // Galería (si no está vacía)
                  if (restaurantData['gallery'] != null && restaurantData['gallery'].isNotEmpty) ...[
                    Text(
                      'Galería',
                      style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.015),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: restaurantData['gallery'].map<Widget>((imageUrl) {
                          return Padding(
                            padding: EdgeInsets.only(right: size.width * 0.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                height: size.height * 0.1,
                                width: size.width * 0.25,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                  ],

                  // Acerca de
                  Text(
                    'Acerca de',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    restaurantData['info'],
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Características/Amenidades
                  Text(
                    'Amenidades',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: (restaurantData['amenidades'] as List<dynamic>).map((amenity) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
                        child: Row(
                          children: [
                            Icon(
                              getAmenityIcon(amenity),
                              size: size.width * 0.06,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: size.width * 0.06), // Espacio entre el ícono y el texto
                            Text(
                              amenity,
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Obtener restaurantes filtrados según la categoría
  Stream<QuerySnapshot> getFilteredRestaurants() {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .where('category', isEqualTo: widget.selectedCategory)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.displayName}', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 255, 65, 81),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFilteredRestaurants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay lugares disponibles en esta categoría.'));
          }

          final restaurants = snapshot.data!.docs;

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurantData = restaurants[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  _showRestaurantModal(context, restaurantData);
                },
                child: Card(
                  margin: EdgeInsets.all(size.width * 0.06),
                  child: ListTile(
                    leading: Image.network(
                      restaurantData['image'],
                      width: size.width * 0.25,
                      fit: BoxFit.cover,
                    ),
                    title: Text(restaurantData['name']),
                    subtitle: Text(restaurantData['category']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

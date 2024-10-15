import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findloapp/pages/Directory/restaurants_screen.dart';
import 'package:flutter/material.dart';


class DirectorioScreen extends StatefulWidget {
  @override
  _DirectorioScreenState createState() => _DirectorioScreenState();
}

class _DirectorioScreenState extends State<DirectorioScreen> {

  // Obtener las categorías desde Firebase
  Stream<QuerySnapshot> getCategories() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }

  // Mapa que asigna cada categoría a un color de degradado específico
  final Map<String, List<Color>> categoryGradients = {
    'Bar': [Colors.redAccent, Colors.orangeAccent],
    'Restaurante': [Colors.greenAccent, Colors.lightGreenAccent],
    'Spa': [Colors.yellowAccent, Colors.orangeAccent],
  };

  // Navegar a la pantalla de restaurantes
  void onCategorySelected(BuildContext context, String categoryName, String displayName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantsScreen(
          selectedCategory: categoryName,
          displayName: displayName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 255, 65, 81),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!.docs;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final categoryData = categories[index].data() as Map<String, dynamic>;

              // Mostramos el displayName en el banner y el categoryName para el filtrado
              return GestureDetector(
                onTap: () {
                  onCategorySelected(
                      context,
                      categoryData['categoryName'],
                      categoryData['displayName']
                  ); // Usamos categoryName para filtrar
                },
                child: BannerItem(
                  imagePath: categoryData["imageURL"],
                  text: categoryData['displayName'],
                  gradientColors: categoryGradients[categoryData['categoryName']] ??  [Colors.blueAccent, Colors.blueAccent], // Color del gradiente
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// BannerItem widget para mostrar las categorías
class BannerItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final List<Color> gradientColors;

  const BannerItem({
    required this.imagePath,
    required this.text,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height *0.24,
      width: double.infinity, // Ancho completo
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientColors[0].withOpacity(0.8), gradientColors[1].withOpacity(0.3)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text, // Aquí usamos el displayName para mostrar en el banner
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.06), // Espacio entre el texto y la flecha
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: size.width * 0.065,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

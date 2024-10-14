import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  String selectedCategory = 'Lo Mejor'; // Categoría por defecto

  // Función para obtener los cupones desde Firebase,
  Stream<QuerySnapshot> getCoupons() {
    if (selectedCategory == 'Lo Mejor') {
      // Muestra solo los cupones recomendados
      return FirebaseFirestore.instance
          .collection('cupones')
          .where('isRecommended', isEqualTo: true)
          .snapshots();
    } else {
      // Filtra por categoría para el resto
      return FirebaseFirestore.instance
          .collection('cupones')
          .where('category', isEqualTo: selectedCategory)
          .snapshots();
    }
  }

  // Cambiar la categoría seleccionada
  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Findtastic',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.04),
            child: CircleAvatar(
              backgroundImage:
              AssetImage('assets/img/no-profile-pic.png') as ImageProvider,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Cupón destacado
          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: CouponHighlightCard(
              imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhhiOdSwr-TssAcDdf06PLl5mzZXdxpzErfQ&s',
              discount: '50% Descuento',
              title: 'Cupón PRINCIPAL',
            ),
          ),
          // Sección de categorías
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryButton(
                    title: 'Lo Mejor',
                    isSelected: selectedCategory == 'Lo Mejor',
                    onTap: () => selectCategory('Lo Mejor'),
                  ),
                  CategoryButton(
                    title: 'Entretenimiento',
                    isSelected: selectedCategory == 'Entretenimiento',
                    onTap: () => selectCategory('Entretenimiento'),
                  ),
                  CategoryButton(
                    title: 'Deportes',
                    isSelected: selectedCategory == 'Deportes',
                    onTap: () => selectCategory('Deportes'),
                  ),
                  CategoryButton(
                    title: 'Gastronomía',
                    isSelected: selectedCategory == 'Gastronomía',
                    onTap: () => selectCategory('Gastronomía'),
                  ),
                  CategoryButton(
                    title: 'Conciertos',
                    isSelected: selectedCategory == 'Conciertos',
                    onTap: () => selectCategory('Conciertos'),
                  ),
                  CategoryButton(
                    title: 'Tours',
                    isSelected: selectedCategory == 'Tours',
                    onTap: () => selectCategory('Tours'),
                  ),
                  CategoryButton(
                    title: 'Cultura',
                    isSelected: selectedCategory == 'Cultura',
                    onTap: () => selectCategory('Cultura'),
                  ),
                ],
              ),
            ),
          ),
          // Línea horizontal de separación
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            height: 1,
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recomendados para ti',
                  style: TextStyle(
                      fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.filter_list),
              ],
            ),
          ),
          // Lista de cupones
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: StreamBuilder<QuerySnapshot>(
                stream: getCoupons(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final coupons = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: coupons.length,
                    itemBuilder: (context, index) {
                      final couponData =
                      coupons[index].data() as Map<String, dynamic>;

                      return CouponCard(
                        imageUrl: couponData['imageURL'],
                        title: couponData['title'],
                        description: couponData['description'],
                        discount: couponData['discount'],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para el cupón destacado
class CouponHighlightCard extends StatelessWidget {
  final String imageUrl;
  final String discount;
  final String title;

  const CouponHighlightCard({
    required this.imageUrl,
    required this.discount,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        width: double.infinity,
        height: size.height * 0.2,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      discount,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Imagen del cupón
            Container(
              margin: EdgeInsets.only(right: size.width * 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  imageUrl,
                  width: size.width * 0.45,
                  height: size.height * 0.15,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para mostrar cada cupón
class CouponCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String discount;

  const CouponCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.01,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(
          children: [
            // Imagen del cupón
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                width: size.width * 0.25,
                height: size.height * 0.13,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sección de descuento
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: size.width * 0.04, // Adaptable
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          discount,
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02), // Espacio adaptable
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Botón de categoría
class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey[500],
              ),
            ),
            SizedBox(height: size.height*0.005),
            // Subrayar la categoría seleccionada
            Container(
              height: 2,
              width: size.width *0.18,
              color: isSelected ? Color.fromARGB(255, 255, 65, 81) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

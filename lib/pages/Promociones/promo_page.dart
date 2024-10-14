import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  // Función para obtener los cupones desde Firebase
  Stream<QuerySnapshot> getCoupons() {
    return FirebaseFirestore.instance.collection('cupones').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/img/no-profile-pic.png') as ImageProvider,
          ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Sección de categorías o tabs (opcional)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Lo Mejor', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Shows'),
                Text('Deportes'),
                Text('Conciertos'),
                Text('Tours'),
              ],
            ),
          ),
          // Lista de cupones
          Expanded(
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
                      imageUrl: couponData['imageURL'], // URL de la imagen del cupón
                      title: couponData['title'],    // Título del cupón
                      description: couponData['description'], // Descripción
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar cada cupón
class CouponCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const CouponCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(
          children: [
            // Imagen del cupón
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
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

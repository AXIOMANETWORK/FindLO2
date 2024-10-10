import 'package:flutter/material.dart';

class VallartaPage extends StatefulWidget {
  const VallartaPage({super.key});

  @override
  State<VallartaPage> createState() => _VallartaPageState();
}

class _VallartaPageState extends State<VallartaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PUERTO VALLARTA'),
        centerTitle: true,
        backgroundColor: Colors.white, // Color de fondo del AppBar
        elevation: 0, // Sin sombra en el AppBar
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BannerItem(
              imagePath: 'assets/img/actividades.jpeg',
              text: 'Actividades por temporada',
              gradientColor: Colors.greenAccent,
            ),
            BannerItem(
              imagePath: 'assets/img/gastronomia.jpg',
              text: 'Gastronomía',
              gradientColor: Colors.redAccent,
            ),
            BannerItem(
              imagePath: 'assets/img/fiestas.png',
              text: 'Fiestas regionales',
              gradientColor: Colors.purpleAccent,
            ),
            BannerItem(
              imagePath: 'assets/img/deporte.jpg',
              text: 'Eventos Deportivos',
              gradientColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color gradientColor;

  const BannerItem({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.gradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción cuando el usuario haga clic en el banner
        print('$text seleccionado'); // Aquí puedes añadir la navegación a otra pantalla
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10), // Espacio entre banners
        height: 200, // Altura del banner
        width: double.infinity, // Ancho completo
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath), // Imagen de fondo
            fit: BoxFit.cover, // Abarca todo el contenedor
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientColor.withOpacity(0.8), Colors.transparent],
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
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10), // Espacio entre el texto y la flecha
                  const Icon(
                    Icons.arrow_forward_ios, // Flecha hacia la derecha
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

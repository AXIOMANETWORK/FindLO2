import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:findloapp/pages/Map/map_page.dart';
import 'package:findloapp/pages/Promociones/promo_page.dart';
import 'package:findloapp/pages/Usuario/user_page.dart';
import 'package:findloapp/pages/Vallarta/vallarta_page.dart';
import 'package:flutter/material.dart';

import '../Directory/directory_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Índice seleccionado de la barra de navegación
  final PageController _pageController = PageController(); // Controlador del PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Actualiza el índice cuando se cambia la página
          });
        },
        children:[
          DirectorioScreen(),
          PromoPage(),
          MapPage(),
          VallartaPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 255, 65, 81),
        animationDuration: const Duration(milliseconds: 400),
        height: MediaQuery.of(context).size.height * 0.07,
        index: _selectedIndex, // Sincroniza con el índice actual
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Cambia el índice cuando el usuario hace clic en un ícono
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ); // Navega a la página correspondiente
        },
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Image.asset(
                  "assets/img/Directorio_Icono.png",
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              const Text(
                "Directorio",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Image.asset(
                  "assets/img/Promociones_Icono.png",
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              const Text(
                "FindTastic",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0), // Añade más espacio vertical
                child: Image.asset(
                  "assets/img/Mapa_Icono.png",
                  height: MediaQuery.of(context).size.height * 0.031,
                  width: MediaQuery.of(context).size.width * 0.055,
                ),
              ),
              const Text(
                "  Mapa  ",
                style: TextStyle(color: Colors.white, fontSize: 12), // Ajusta el tamaño del texto
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Image.asset(
                  "assets/img/Vallara.png",
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
              ),
              const Text(
                " Vallarta ",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Image.asset(
                  "assets/img/Usuario_Icono.png",
                  height: MediaQuery.of(context).size.height * 0.035,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              const Text(
                " Usuario ",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

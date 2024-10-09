import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trabajo/pages/Map/map_page.dart';
import 'package:flutter_trabajo/pages/Promociones/promo_page.dart';
import 'package:flutter_trabajo/pages/Usuario/user_page.dart';
import 'package:flutter_trabajo/pages/Vallarta/vallarta_page.dart';

import '../Directory/directory_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(); // Controlador del PageView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index; // Actualizar el índice seleccionado
                });
              },
              children: [
                MapPage(),
                DirectorioScreen(),
                PromoPage(),
                VallartaPage(),
                UserPage(),
              ],
            ),
          ),
        ],
      ),
      // BottomNavigationBar en la parte inferior de la pantalla
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color.fromARGB(255, 255, 65, 81),
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Cambia el índice cuando el usuario hace clic en un ícono
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          ); // Navegar a la página correspondiente
        },
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Mapa_Icono.png",
                height: MediaQuery.of(context).size.height * 0.031,
                width: MediaQuery.of(context).size.width * 0.055,
              ),
              Text(
                "Mapa",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Directorio_Icono.png",
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Directorio",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Promociones_Icono.png",
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "FindTastic",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Vallara.png",
                height: MediaQuery.of(context).size.height * 0.035,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Vallarta",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Usuario_Icono.png",
                height: MediaQuery.of(context).size.height * 0.035,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Usuario",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





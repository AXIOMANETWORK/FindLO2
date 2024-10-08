import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
          // Agregamos el AppBar personalizado
          CustomAppBar(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index; // Actualizar el índice seleccionado
                });
              },
              children: [
                MapaScreen(), // Tus pantallas personalizadas
                DirectorioScreen(),
                PromocionesScreen(),
                VallartaScreen(),
                UsuarioScreen(),
                ContactoScreen(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/Contacto_Icono.png",
                height: MediaQuery.of(context).size.height * 0.035,
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "Contacto",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Pantallas de ejemplo para navegar
class MapaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mapa Screen'));
  }
}

class PromocionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Promociones Screen'));
  }
}

class VallartaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Vallara Screen'));
  }
}

class UsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Usuario Screen'));
  }
}

class ContactoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Contacto Screen'));
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16), // Espaciado para la barra de estado
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFD5C69), // Rosa claro
            Color(0xFFFFFFFF), // Rosa oscuro
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila que contiene el título y el botón de búsqueda
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "FINDLO",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Acción al presionar el botón de búsqueda
                },
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Selector de categorías (simulación de dropdown)
          Row(
            children: [
              CategorySelector(
                categories: ["Topics", "Restaurant"], // Lista de categorías
                selectedIndex: 1, // Indice de la categoría seleccionada
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your keywords",
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;

  const CategorySelector({
    required this.categories,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: categories[selectedIndex],
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: Colors.pink[200], // Color del dropdown
        underline: SizedBox(),
        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: TextStyle(color: Colors.green),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Acción al seleccionar una nueva categoría
        },
      ),
    );
  }
}

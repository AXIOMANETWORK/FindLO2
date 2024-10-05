import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Listado de pantallas o widgets a mostrar según el índice seleccionado
  static const List<Widget> _pages = <Widget>[
    Center(child: Text("Home Page")),
    Center(child: Text("Map Page")),
    Center(child: Text("Notifications")),
    Center(child: Text("Profile Page")),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambiar el índice de la página seleccionada
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Agregamos el AppBar personalizado
          CustomAppBar(),
          Expanded(
            child: _pages[_selectedIndex], // Mostrar la página seleccionada
          ),
        ],
      ),
      // BottomNavigationBar en la parte inferior de la pantalla
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Color.fromARGB(255,255, 65, 81),
        animationDuration: Duration(milliseconds: 400),
        onTap: (index){
          print(index);
        },
        items:[
          Image.asset(
            "assets/img/Mapa_Icono.png",
            height: 20,
            width: 20,
          ),
          Image.asset(
            "assets/img/Directorio_Icono.png",
            height: 20,
            width: 20,
          ),
          Image.asset(
            "assets/img/Promociones_Icono.png",
            height: 20,
            width: 20,
          ),
          Image.asset(
            "assets/img/Vallara.png",
            height: 20,
            width: 20,
          ),
          Image.asset(
            "assets/img/Usuario_Icono.png",
            height: 20,
            width: 20,
          ),
          Image.asset(
            "assets/img/Contacto_Icono.png",
            height: 20,
            width: 20,
          ),
        ]
      ),
    );
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

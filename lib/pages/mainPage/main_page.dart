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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // El índice seleccionado actualmente
        selectedItemColor: Colors.pink[400], // Color del ítem seleccionado
        unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
        onTap: _onItemTapped, // Llamar cuando se selecciona un ítem
        type: BottomNavigationBarType.fixed, // Para mantener todos los ítems visibles
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

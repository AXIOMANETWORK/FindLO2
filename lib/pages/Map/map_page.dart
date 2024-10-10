import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('Mapa Screen')),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(160); // Establece la altura que deseas

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16), // Espaciado para la barra de estado
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 255, 65, 81), Colors.white],
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
              Spacer(),
              Text(
                "FindLO",
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  // Acción al presionar el botón de búsqueda
                  print("Botón de búsqueda presionado");
                },
                icon: const Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Selector de categorías (simulación de dropdown con botones)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón para "Topics"
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Topics seleccionado");
                    },
                    child: Text(
                      'Topics',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Divider entre botones
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                // Botón para "Restaurant"
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Restaurant seleccionado");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Restaurant',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.help_outline, color: Colors.grey, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

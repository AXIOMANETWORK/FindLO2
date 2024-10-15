import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        userData = userDoc.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 65, 81), // Color de fondo del AppBar
        elevation: 0, // Sin sombra en el AppBar
        automaticallyImplyLeading: false,
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 255, 65, 81), Colors.orangeAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: userData?['photoURL'] != null
                      ? NetworkImage(userData!['photoURL'])
                      : AssetImage('assets/img/no-profile-pic.png') as ImageProvider,
                ),

                SizedBox(width: size.width * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData?['name'] ?? 'Nombre no disponible',
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userData?['email'] ?? 'Email no disponible',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white, size: size.width *0.07,),
                  onPressed: () {
                    // Acción para editar el perfil
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildMenuItem(Icons.person, 'Cuenta', context),
                _buildMenuItem(Icons.notifications, 'Notificaciones', context),
                _buildMenuItem(Icons.support, 'Soporte', context),
                _buildMenuItem(Icons.share, 'Redes Sociales', context),
                SizedBox(height: size.height * 0.035),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.redAccent, size: size.width * 0.07,),
                  title: Text('Log out', style: TextStyle(fontSize: size.width *0.045),),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Colors.grey, size: size.width * 0.07,),
      title: Text(title, style: TextStyle(fontSize: size.width * 0.048)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: size.width * 0.067,),
      onTap: () {
        // Acciones para cada opción de menú
      },
    );
  }
}

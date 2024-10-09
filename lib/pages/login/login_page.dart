import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final verticalMargin = MediaQuery.of(context).size.height * 0.05;
    final textFieldsMargin = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _textLogin(),
                SizedBox(height: 10),
                _textLoginDesc(),
                SizedBox(height: 30),
                _textFieldEmail(),
                SizedBox(height: textFieldsMargin),
                _textFieldPassword(),
                _buttonLogin(),
                _textForgotPassword(),
                SizedBox(height: 60),
                _textLoginAlternatives(),
                SizedBox(height: 20),
                _buttonGoogleLogin(),
                SizedBox(height: textFieldsMargin),
                _buttonFacebookLogin(),
                SizedBox(height: textFieldsMargin),
                _textDontHaveAccount()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textLogin(){
    return Text(
      "Login",
      style: GoogleFonts.dancingScript(
        textStyle: TextStyle(
          fontSize: 45,
          color:  Color.fromARGB(255, 255, 65, 81),
        )

      ),
    );
  }
  Widget _textLoginAlternatives(){
    return Text(
      "or Login With",
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
    );
  }
  Widget _textLoginDesc(){
    return Text(
      "Add your details to login",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }
  Widget _textFieldEmail() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Your email",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      ),
    );
  }
  Widget _textFieldPassword() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }
  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            // Obtener los valores de los campos de email y contraseña
            String email = _emailController.text.trim();
            String password = _passwordController.text.trim();

            try {
              // Intentar iniciar sesión con Firebase Authentication
              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

              // Si la autenticación es exitosa, redirigir a la página principal
              Navigator.pushReplacementNamed(context, "principal");
            } catch (e) {
              // Si ocurre un error (usuario no encontrado, contraseña incorrecta, etc.), mostrar un mensaje
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login failed: ${e.toString()}")),
              );
            }
          }
        },
        child: Text("Login", style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 79, 129, 189),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
  Widget _textDontHaveAccount(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          SizedBox(width: 7),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,"register");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 17,
              ),
            ),
          ),
        ],
      );
  }
  Widget _textForgotPassword(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,"rePassword");
            },
            child: Text(
              "Forgot your password? ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17
              ),
            ),
          ),

        ],
      );
  }
  Widget _buttonGoogleLogin() {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton.icon(
            onPressed: controller.isLoading
                ? null // Desactiva el botón si está cargando
                : () async {
              try {
                await controller.signInWithGoogle();
                // Redirige al usuario si la autenticación es exitosa
                if (controller.user != null) {
                  Navigator.pushReplacementNamed(context, 'principal');
                } else if (controller.errorMessage != null) {
                  // Muestra un mensaje de error si ocurre algún problema
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(controller.errorMessage!)),
                  );
                }
              } catch (e) {
                print('Error during Google sign-in: $e');
              }
            },
            icon: controller.isLoading
                ? CircularProgressIndicator() // Muestra el indicador de carga
                : Image.asset(
              'assets/img/Google branding icon.png',
              width: 24,
              height: 24,
            ),
            label: Text("Login with Google", style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        );
      },
    );
  }
  Widget _buttonFacebookLogin() {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton.icon(
            onPressed: controller.isLoading
                ? null // Desactiva el botón si está cargando
                : () async {
              try {
                await controller.signInWithFacebook();
                // Redirige al usuario si la autenticación es exitosa
                if (controller.user != null) {
                  Navigator.pushReplacementNamed(context, 'principal');
                } else if (controller.errorMessage != null) {
                  // Muestra un mensaje de error si ocurre algún problema
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(controller.errorMessage!)),
                  );
                }
              } catch (e) {
                print('Error during Facebook sign-in: $e');
              }
            },
            icon: controller.isLoading
                ? CircularProgressIndicator() // Muestra el indicador de carga
                : Image.asset(
              'assets/img/Facebook logo icon.png',
              width: 24,
              height: 24,
            ),
            label: Text("Login with Facebook", style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[400],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        );
      },
    );
  }



}

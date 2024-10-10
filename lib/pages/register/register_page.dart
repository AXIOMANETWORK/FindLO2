import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
    final address = _addressController.text;
    final name = _nameController.text;

    try {
      // Creacion del usuario
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User id
      String uid = userCredential.user!.uid;

      //Guardar el resto de datos en firebase
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'phone': phone,
        'address': address,
        'name' : name
      });

    } catch (e) {
      print('Registration error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final verticalMargin = MediaQuery.of(context).size.height * 0.05;
    final textFieldsMargin = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _textRegister(),
                SizedBox(height: 10),
                _textRegisterDesc(),
                SizedBox(height: 30),
                _textFieldName(),
                SizedBox(height: textFieldsMargin),
                _textFieldEmail(),
                SizedBox(height: textFieldsMargin),
                _textFieldPhone(),
                SizedBox(height: textFieldsMargin),
                _textFieldAddress(),
                SizedBox(height: textFieldsMargin),
                _textFieldPassword(),
                SizedBox(height: textFieldsMargin),
                _textFieldConfirmPassword(),
                SizedBox(height: textFieldsMargin),
                _buttonRegister(),
                _textHaveAccount()
              ],
            ),
          ),

        ),
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
        controller:_emailController ,
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
  Widget _textFieldPhone() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller:_phoneController ,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Mobile No",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone';
          }
          return null;
        },
      ),
    );
  }
  Widget _textFieldName() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller:_nameController ,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: "Name",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
      ),
    );
  }
  Widget _textFieldAddress() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller:_addressController ,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: "Address",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your address';
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
  Widget _textFieldConfirmPassword() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          } else if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
  Widget _textRegister(){
    return Text(
      "Sign Up",
      style: GoogleFonts.dancingScript(
          textStyle: TextStyle(
            fontSize: 45,
            color:  Color.fromARGB(255, 255, 65, 81),
          )
      ),
    );
  }
  Widget _textRegisterDesc(){
    return Text(
      "Add your details to sign up",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }
  Widget _textHaveAccount(){
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17
            ),
          ),
          SizedBox(width: 7),
          GestureDetector(
            onTap: (){
              Navigator.pushReplacementNamed(context,"login");
            },
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:  Color.fromARGB(255, 255, 65, 81),
                  fontSize: 17
              ),
            ),
          ),
        ],
      );
  }
  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _register();
            Navigator.pushReplacementNamed(context, "login");
          }
        },
        child: Text("Sign up", style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color:  Color.fromARGB(255, 255, 65, 81),
              width: 1.5
          ),
          backgroundColor: Colors.white,
          foregroundColor: Color.fromARGB(255, 255, 65, 81),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

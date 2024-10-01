import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _conPass = TextEditingController();
  bool passwordVisible=false;

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
            child: Column(
              children: [
                SizedBox(height: 10),
                _textNewPass(),
                SizedBox(height: 10),
                _textNewPassDesc(),
                SizedBox(height: 55),
                _textFieldNewPass(),
                SizedBox(height: textFieldsMargin),
                _textFieldConPass(),
                SizedBox(height: textFieldsMargin),
                _buttonNext(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textNewPass(){
    return Text(
      "New Password",
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }

  Widget _textNewPassDesc(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: Text(
        "Please enter your email to receive a link to create a new password via email",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _textFieldNewPass() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _newPass,
        obscureText: passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: "New Password",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: IconButton(
            icon: Icon(passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(
                    () {
                  passwordVisible = !passwordVisible;
                },
              );
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your new password';
          }
          return null;
        },
      ),
    );
  }

  Widget _textFieldConPass() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _conPass,
        obscureText: passwordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: IconButton(
            icon: Icon(passwordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(
                    () {
                  passwordVisible = !passwordVisible;
                },
              );
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password to confirm it';
          } else if (value != _newPass.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }


  Widget _buttonNext() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await _firebaseAuth.sendPasswordResetEmail(email: _newPass.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Text("Password Change Confirmed"),
              ),
            );
            Navigator.pushReplacementNamed(context, "login");
          } catch (e) {
            print(e);
          }
        },
        child: Text("Next", style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 79, 129, 189),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
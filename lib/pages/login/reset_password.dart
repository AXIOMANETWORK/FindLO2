import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _email = TextEditingController();

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
                _textReset(),
                SizedBox(height: 10),
                _textResetDesc(),
                SizedBox(height: 55),
                _textFieldEmail(),
                SizedBox(height: textFieldsMargin),
                _buttonSend(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textReset(){
    return Text(
      "Reset Password",
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }

  Widget _textResetDesc(){
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

  Widget _textFieldEmail() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _email,
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

  Widget _buttonSend() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await _firebaseAuth.sendPasswordResetEmail(email: _email.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Text("Email sent"),
              ),
            );
            Navigator.pushReplacementNamed(context, "coPassword");
          } catch (e) {
            print(e);
          }
        },
        child: Text("Send", style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 79, 129, 189),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

import 'package:crud/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUser();
}

class _CreateUser extends State<CreateUser> {
  final _nomeController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Colors.red[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.name,
                  decoration: inputDecoration("Usuário")),
              Container(
                height: 20,
              ),
              TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration("Email")),
              Container(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: inputDecoration("Senha"),
              ),
              Container(
                height: 30,
              ),
              TextFormField(
                  controller: _password2Controller,
                  keyboardType: TextInputType.name,
                  decoration: inputDecoration("Confirmar Senha")),
              Container(
                height: 20,
              ),
              ElevatedButton(
                  child: Text(
                    "Cadastrar",
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (_passwordController == _password2Controller) {
                      cadastrar();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Senhas diferentes'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  }),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  cadastrar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha fraca'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este email já foi cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.red[800],
      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
      labelText: labelText,
      fillColor: Colors.red,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}

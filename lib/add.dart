import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud/db/db.dart';

class Add extends StatefulWidget {
  Add({required this.db});
  Database db;
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageRatingController = new TextEditingController();
  TextEditingController launchYearController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController durationController = new TextEditingController();
  TextEditingController languageController = new TextEditingController();
  TextEditingController ratingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text("Adicionar Filme"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Nome do Filme"),
                controller: nameController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Classificação Etária"),
                controller: ageRatingController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Ano de Lançamento"),
                controller: launchYearController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Gênero"),
                controller: genderController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Duração"),
                controller: durationController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Idioma"),
                controller: languageController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Avaliação (1 a 5)"),
                controller: ratingController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: ElevatedButton(
              onPressed: () {
                widget.db.createMovie(
                    nameController.text,
                    ageRatingController.text,
                    launchYearController.text,
                    genderController.text,
                    durationController.text,
                    languageController.text,
                    ratingController.text);
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              child: Text(
                "Adicionar",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud/db/db.dart';

class View extends StatefulWidget {
  View({required this.movie, required this.db});
  Map movie;
  Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
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
    nameController.text = widget.movie['name'];
    ageRatingController.text = widget.movie['age_rating'];
    launchYearController.text = widget.movie['launch_year'];
    genderController.text = widget.movie['gender'];
    durationController.text = widget.movie['duration'];
    languageController.text = widget.movie['language'];
    ratingController.text = widget.movie['rating'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text("Editar Filme"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.db.deleteMovie(widget.movie["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: inputDecoration("Nome do Filme"),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
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
                widget.db.updateMovie(
                    widget.movie['id'],
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
                "Atualizar",
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

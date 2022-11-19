import 'package:crud/add.dart';
import 'package:crud/db/db.dart';
import 'package:crud/view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardflix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lista de Filmes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database db;

  List allMovies = [];

  initialise() {
    db = Database();
    db.initiliase();
    db.getAllMovies().then((value) => {
          setState(() => {allMovies = value!})
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: allMovies.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View(
                              movie: allMovies[index],
                              db: db,
                            ))).then((value) => {
                      if (value != null) {initialise()}
                    });
              },
              contentPadding: EdgeInsets.only(right: 30, left: 36),
              title: Text(allMovies[index]['name']),
              trailing: Text(allMovies[index]['language']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) {
            if (value != null) {
              initialise();
            }
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:crud/add.dart';
import 'package:crud/db/db.dart';
import 'package:crud/home.dart';
import 'package:crud/view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                      // controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration("Email")),
                  Container(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: inputDecoration("Senha"),
                  ),
                  Container(
                    height: 30,
                  ),
                  ElevatedButton(
                      child: Text(
                        "Entrar",
                      ),
                      onPressed: () {
                        // login();
                      }),
                  Container(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // TextButton.icon(
                        //   icon: Icon(Icons.people, size: 16),
                        //   label: Text('Cadastre-se'),
                        //   onPressed: () => Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => CreateUser())),
                        // ),
                        TextButton.icon(
                          icon: Icon(Icons.replay_rounded, size: 16),
                          label: Text('Esqueceu sua senha ?'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/ranking'),
                        ),
                      ]),
                ],
              ),
            ),
          ),
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

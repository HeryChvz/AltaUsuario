import 'package:alta_usuarios/user.dart';
import 'package:flutter/material.dart';
import 'controllers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen 3 Registro Usuario',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Examen 3 App con API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nombre = "Default";
  String apellido = "Default";
  List<Usuario> response = [];

  _MyHomePageState() {
    getUser().then((value) {
      response = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Nombre',
                ),
                onChanged: (valor) {
                  if (valor.isEmpty) {
                    nombre = "";
                    return;
                  }
                  setState(() {
                    nombre = valor;
                  });
                },
              ),
              TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Apellido',
                ),
                onChanged: (valor) {
                  if (valor.isEmpty) {
                    apellido = "";
                    return;
                  }
                  setState(() {
                    apellido = valor;
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: response
                .map((e) => ListTile(
                      title: Text(
                        '${e.id}. ${e.nombre} ${e.apellido}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await createUser(nombre, apellido);
          response = await getUser();
          setState(() {});
        },
        tooltip: 'Agregar',
        child: Icon(Icons.add),
      ),
    );
  }
}

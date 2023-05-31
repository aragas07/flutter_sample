import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future getImage() async{
    try{
      PickedFile? image = await ImagePicker().getImage(source: ImageSource.camera);
      final imageTemp = File(image!.path);
      setState(()=>this.image = imageTemp);
    }on SocketException catch(e){
      print('Failed to pick image: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plant Pitcher"),backgroundColor: Colors.green),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: (){getImage();},
                  color: Colors.blue,
                  child: const Text(
                    "SCAN",
                    style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19
                    )
                  )
                )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: image != null ? Image.file(File(image!.path)) : Text("null"),
              ),
              _output != null ? Text(
                (_output![0]['label'].toString().substring(2)),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                ):Text(""),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Characteristics", textAlign: TextAlign.right, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Container(
                  child: Column(
                    children: [
                      for(int x = 0; x < _items![0]['Characteristics'].length ;x++)...[
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text("• "+_items![0]['Characteristics'][x].toString())
                        ),
                      ],
                    ],
                  )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.only(top: 7),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Etymology", textAlign: TextAlign.right, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text("• "+_items![0]['Etymology'].toString())
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.only(top: 7),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Ecology and Distribution", textAlign: TextAlign.right, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text("• "+_items![0]['Ecology and Distribution'].toString())
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.only(top: 7),
                  alignment: Alignment.bottomLeft,
                  child: const Text("Conservation Notes", textAlign: TextAlign.right, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text("• "+_items![0]['Conservation Notes'].toString())
                )

            ],
          ),
        )
      )
    );
  }
}

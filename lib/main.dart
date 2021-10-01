import 'package:datos/user_prederence.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreference userPreference = UserPreference();
  await userPreference.initPrefers();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final ageController = TextEditingController();

  List<String> myMusic = [];

  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    UserPreference userPreference = UserPreference();

    nameController.text = userPreference.name;
    last_nameController.text = userPreference.last_name;
    ageController.text = "${userPreference.age}";
    myMusic = userPreference.favoriteMusic;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App para guardar datos"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: nameController,
                onChanged: (String value) {
                  userPreference.name = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4), hintText: "Nombre"),
              ),
              TextField(
                controller: last_nameController,
                onChanged: (String value) {
                  userPreference.last_name = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4), hintText: "Apellido"),
              ),
              TextField(
                controller: ageController,
                onChanged: (String value) {
                  try {
                    userPreference.age = int.parse(value);
                  } catch (e) {}
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4), hintText: "Edad"),
              ),
              DropdownButton(
                  value: userPreference.married,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text("Casado"),
                      value: true,
                    ),
                    DropdownMenuItem(
                      child: Text("Soltero"),
                      value: false,
                    ),
                  ],
                  onChanged: (bool? value) {
                    setState(() {
                      userPreference.married = value!;
                    });
                  }),
              musicCheckbox(),
              Spacer(),
              TextButton(
                  onPressed: () {
                    setState(() {
                      nameController.text = "";
                      last_nameController.text = "";
                      ageController.text = "0";
                      myMusic = [];
                      userPreference.clean();
                    });
                  },
                  child: Text("Limpiar"),
                  style: TextButton.styleFrom(primary: Colors.deepOrange))
            ],
          ),
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget musicCheckbox() {
    List<String> music = ["Rock", "Pop", "Clasica", "Remix"];
    return Column(
      children: music
          .map(
            (m) => CheckboxListTile(
                title: Text(m),
                secondary: Icon(Icons.music_note),
                activeColor: Colors.green,
                value: myMusic.indexOf(m) >= 0,
                onChanged: (_) {
                  if (myMusic.indexOf(m) < 0) {
                    myMusic.add(m);
                  } else {
                    myMusic.remove(m);
                  }
                  userPreference.favoriteMusic = myMusic;
                  setState(() {});
                }),
          )
          .toList(),
    );
  }
}

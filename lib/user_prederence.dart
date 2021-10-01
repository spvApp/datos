import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences _prefers;

  initPrefers() async {
    UserPreference._prefers = await SharedPreferences.getInstance();
  }

  String get name {
    //Opcion 1
    /*if (_prefers.getString("name") == null) {
      return ("No hay nombre");
    }*/
    // Opcion 2
    //Si es null retorna vacio y si es distinto de null retorna "name"
    return _prefers.getString("name") ?? " ";
  }

  set name(String value) {
    _prefers.setString("name", value);
  }

  String get last_name {
    return _prefers.getString("last_name") ?? " ";
  }

  set last_name(String value) {
    _prefers.setString("last_name", value);
  }

  int get age {
    return _prefers.getInt("age") ?? 0;
  }

  set age(int value) {
    _prefers.getInt("age");
  }

  bool get married {
    return _prefers.getBool("married") ?? false;
  }

  set married(bool value) {
    _prefers.getBool("married");
  }

  List<String> get favoriteMusic {
    return _prefers.getStringList("music") ?? [];
  }

  set favoriteMusic(List<String> value) {
    _prefers.setStringList("music", value);
  }

  clean() {
    name = "";
    last_name = "";
    age = 0;
    married = false;
    favoriteMusic = [];
  }
}

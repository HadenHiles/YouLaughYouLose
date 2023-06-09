import 'package:shared_preferences/shared_preferences.dart';

class CurrentGameCode {
  Future save(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_game_code', code);
  }

  Future<String?> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_game_code');
  }

  Future invalidate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_game_code');
  }
}

class CurrentPlayerName {
  Future save(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_player_name', name);
  }

  Future<String?> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_player_name');
  }

  Future invalidate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_player_name');
  }
}

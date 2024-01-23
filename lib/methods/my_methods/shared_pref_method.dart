import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void saveUserData(
      {required String email,
      required String password,
      required String name,
      required String grade,
      required String type,
      required String phone,
      required String uid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('phone', phone);
    await prefs.setString('grade', grade);
    await prefs.setString('type', type);
    await prefs.setString('uid', uid);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? '';
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? '';
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  Future<String?> getGrade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('grade') ?? '';
  }

  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone') ?? '';
  }

  Future<String?> getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('type') ?? '';
  }

  Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid') ?? '';
  }
}

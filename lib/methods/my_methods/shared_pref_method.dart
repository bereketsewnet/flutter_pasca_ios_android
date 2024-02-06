import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void saveUserData(
      {required String email,
      required String password,
      required String name,
      required String grade,
      required String type,
      required String phone,
      required String uid,
      required String profilePic}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // setter for all at once
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('phone', phone);
    await prefs.setString('grade', grade);
    await prefs.setString('type', type);
    await prefs.setString('uid', uid);
    await prefs.setString('profilePic', profilePic);
  }

  // getter of each if in case i need current information
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

  Future<String?> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profilePic') ?? '';
  }

  // setter of each by one by one if i case any update for my information
  Future<String?> setProfilePic(String profilePic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', profilePic);
  }

  Future<String?> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', name);
  }

  Future<String?> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', email);
  }

  Future<String?> setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', phone);
  }

  Future<String?> setType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', type);
  }

  Future<String?> setUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', uid);
  }

  Future<String?> setGrade(String grade) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', grade);
  }

  Future<String?> setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePic', password);
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pasca/methods/my_methods/shared_pref_method.dart';
// Function to check connectivity
Future<void> checkConnectivity() async {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users');
  String uid = await SharedPref().getUid() ?? '';
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none && connectivityResult != ConnectivityResult.bluetooth) {
    // No internet connection
    try {
      dbRef.child(uid).update({'isOnline' : false});
      print('Offline');
    }catch (error){
      print(error);
    }

  } else {
    // Internet connection available
    try {
      dbRef.child(uid).update({'isOnline' : true});
      print('Online');
    }catch (error){
      print(error);
    }
  }
}

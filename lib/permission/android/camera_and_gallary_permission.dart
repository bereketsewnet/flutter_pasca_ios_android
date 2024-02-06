import 'package:permission_handler/permission_handler.dart';
Future<void> checkPermissions() async {
  if (await Permission.camera.isDenied) {
    await Permission.camera.request();
  }

  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }
}

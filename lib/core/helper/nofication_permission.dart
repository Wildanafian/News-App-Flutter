import 'package:permission_handler/permission_handler.dart';

Future<void> requestCameraPermission() async {
  var status = await Permission.camera.status;

  if (status.isDenied) {
    if (await Permission.camera.request().isGranted) {
      print("Camera permission granted.");
    } else {
      await Permission.camera.request();
      print("Camera permission denied.");
    }
  } else if (status.isPermanentlyDenied) {
  } else if (status.isGranted) {
    print("Camera permission already granted.");
  }
}

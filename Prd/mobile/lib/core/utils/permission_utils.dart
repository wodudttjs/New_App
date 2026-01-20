import 'package:permission_handler/permission_handler.dart';

Future<bool> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  return status.isGranted;
}

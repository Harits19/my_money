import 'package:flutter/material.dart';
import 'package:my_money/src/app.dart';
import 'package:my_money/src/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MyApp());
}

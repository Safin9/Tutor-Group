import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_group/screens/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storage.initStorage;
  runApp(const MyApp());
}

final storage = GetStorage();

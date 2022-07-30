import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_group/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storage.initStorage;
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final storage = GetStorage();

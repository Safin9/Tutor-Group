import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tutor_group/firebase_options.dart';
import 'package:tutor_group/providers/phone_code_provider.dart';

import 'package:tutor_group/providers/user_provider.dart';
import 'package:tutor_group/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;

  await storage.initStorage;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => PhoneCodeAndNumberProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ], child: const MyApp()),
  );
  FlutterNativeSplash.remove();
}

final storage = GetStorage();

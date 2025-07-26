import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:debale/core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  // await Firebase.initializeApp();
  
  // Initialize Hive
  // await Hive.initFlutter();
  
  runApp(
    const ProviderScope(
      child: DebaleApp(),
    ),
  );
}

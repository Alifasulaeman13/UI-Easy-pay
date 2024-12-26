import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Add error handling for Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint('Flutter Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    };

    // Perbaikan untuk error handling platform
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      debugPrint('Error Details: ${errorDetails.exception}');
      return Container(
        alignment: Alignment.center,
        child: Text(
          'Error: ${errorDetails.exception}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    };

    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stack');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2C5BA6),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C5BA6),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

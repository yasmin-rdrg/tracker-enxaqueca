import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const AppEnxaqueca());
}

class AppEnxaqueca extends StatelessWidget {
  const AppEnxaqueca({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Enxaqueca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF550C18),
          primary: const Color(0xFF550C18),
          secondary: const Color(0xFF786452),
          surface: const Color(0xFFF7DAD9),
          onPrimary: const Color(0xFFF7DAD9),
          onSurface: const Color(0xFF443730),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7DAD9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF550C18),
          foregroundColor: Color(0xFFF7DAD9),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Color(0xFFA5907E), width: 0.5),
          ),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Color(0xFF550C18),
          thumbColor: Color(0xFF550C18),
          inactiveTrackColor: Color(0xFFA5907E),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF550C18),
            foregroundColor: const Color(0xFFF7DAD9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF550C18),
            side: const BorderSide(color: Color(0xFF550C18)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFA5907E)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFA5907E)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF550C18), width: 1.5),
          ),
          hintStyle: const TextStyle(color: Color(0xFFA5907E)),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF443730)),
          bodyLarge: TextStyle(color: Color(0xFF443730)),
          titleMedium: TextStyle(color: Color(0xFF443730)),
        ),
        useMaterial3: true,
      ),
      home: const HomeTela(),
    );
  }
}
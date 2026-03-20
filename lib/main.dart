import 'package:flutter/material.dart';
import 'investimentos.dart'; // nova tela

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Investimentos(), // chama a tela de investimentos
    );
  }
}

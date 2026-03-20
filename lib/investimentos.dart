import 'package:flutter/material.dart';
import 'dart:math';

class Investimentos extends StatefulWidget {
  const Investimentos({super.key});

  @override
  State<Investimentos> createState() => _InvestimentosState();
}

class _InvestimentosState extends State<Investimentos> {
  double valorMensal = 0.0;
  int meses = 0;
  double taxa = 0.0;

  double calcularSemJuros() {
    return valorMensal * meses;
  }

  double calcularComJuros() {
    double i = (taxa / 100) / 12; // ✅ corrigido (taxa mensal)

    if (i == 0) return calcularSemJuros();

    double montante = 0;

    for (int t = 1; t <= meses; t++) {
      montante += valorMensal * pow(1 + i, meses - t);
    }

    return montante;
  }

  void resultado() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.lightBlue[50],
          title: const Text(
            "Resultado",
            style: TextStyle(color: Colors.lightBlue),
          ),
          content: Text(
            "Total sem juros: R\$ ${calcularSemJuros().toStringAsFixed(2)}\n"
            "Total com juros: R\$ ${calcularComJuros().toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          image: DecorationImage(
            image: const AssetImage("assets/fundo.webp"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.lightBlue.withOpacity(0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30.0,
            children: [
              const Center(
                child: Text(
                  "Simulador de Investimentos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.lightBlue,
                  ),
                ),
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Investimento mensal",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  valorMensal = double.tryParse(value) ?? 0;
                },
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Número de meses",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  meses = int.tryParse(value) ?? 0;
                },
              ),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Taxa de juros (%) ao ano",
                  labelStyle: TextStyle(color: Colors.lightBlue),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  taxa = double.tryParse(value) ?? 0;
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    onPressed: () => resultado(),
                    child: const Text("Simular"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Sair"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

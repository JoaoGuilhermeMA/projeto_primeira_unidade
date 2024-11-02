import 'package:flutter/material.dart';

class TelaEncontroDiario extends StatelessWidget {
  const TelaEncontroDiario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encontro Diário"),
      ),
      body: Center(
        child: Text("Conteúdo do Encontro Diário"),
      ),
    );
  }
}

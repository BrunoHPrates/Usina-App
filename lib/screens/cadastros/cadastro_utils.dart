import 'package:flutter/material.dart';

class CadastroCard extends StatelessWidget {
  final Widget child;

  const CadastroCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ),
      ),
    );
  }
}

String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes/${data.year}';
}

Future<DateTime?> escolherData(
  BuildContext context, {
  DateTime? dataInicial,
}) {
  final hoje = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: dataInicial ?? hoje,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}

InputDecoration decoracaoCampo(String label) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(),
  );
}
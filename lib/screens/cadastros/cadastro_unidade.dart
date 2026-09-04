import 'package:flutter/material.dart';

import '../../models/unidade.dart';
import 'cadastro_utils.dart';

class CadastroUnidadePage extends StatefulWidget {
	const CadastroUnidadePage({super.key});

	@override
	State<CadastroUnidadePage> createState() => _CadastroUnidadePageState();
}

class _CadastroUnidadePageState extends State<CadastroUnidadePage> {
	final formKey = GlobalKey<FormState>();
	final nomeController = TextEditingController();

	@override
	void dispose() {
		nomeController.dispose();
		super.dispose();
	}

	void salvar() {
		if (!formKey.currentState!.validate()) return;

		final unidade = Unidade(id: 0, nome: nomeController.text.trim());
		debugPrint('Unidade: ${unidade.nome}');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Unidade cadastrada com sucesso!')),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Unidade')),
			body: SingleChildScrollView(
				child: CadastroCard(
					child: Form(
						key: formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								TextFormField(
									controller: nomeController,
									decoration: decoracaoCampo('Nome'),
									validator: (valor) => valor == null || valor.trim().isEmpty
											? 'Informe o nome'
											: null,
								),
								const SizedBox(height: 24),
								ElevatedButton(
									onPressed: salvar,
									child: const Text('Salvar'),
								),
							],
						),
					),
				),
			),
		);
	}
}

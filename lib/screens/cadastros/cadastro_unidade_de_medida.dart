import 'package:flutter/material.dart';

import '../../models/unidade_de_medida.dart';
import 'cadastro_utils.dart';

class CadastroUnidadeDeMedidaPage extends StatefulWidget {
	const CadastroUnidadeDeMedidaPage({super.key});

	@override
	State<CadastroUnidadeDeMedidaPage> createState() => _CadastroUnidadeDeMedidaPageState();
}

class _CadastroUnidadeDeMedidaPageState extends State<CadastroUnidadeDeMedidaPage> {
	final formKey = GlobalKey<FormState>();
	final nomeController = TextEditingController();
	final simboloController = TextEditingController();

	@override
	void dispose() {
		nomeController.dispose();
		simboloController.dispose();
		super.dispose();
	}

	void salvar() {
		if (!formKey.currentState!.validate()) return;
		final unidade = UnidadeDeMedida(
			id: 0,
			nome: nomeController.text.trim(),
			simbolo: simboloController.text.trim(),
		);
		debugPrint('Unidade de medida: ${unidade.nome} (${unidade.simbolo})');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Unidade de medida cadastrada com sucesso!')),
		);
	}

	String? validarObrigatorio(String? valor) =>
			valor == null || valor.trim().isEmpty ? 'Preencha o campo' : null;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Unidade de Medida')),
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
									validator: validarObrigatorio,
								),
								const SizedBox(height: 16),
								TextFormField(
									controller: simboloController,
									decoration: decoracaoCampo('Símbolo'),
									validator: validarObrigatorio,
								),
								const SizedBox(height: 24),
								ElevatedButton(onPressed: salvar, child: const Text('Salvar')),
							],
						),
					),
				),
			),
		);
	}
}

import 'package:flutter/material.dart';

import '../../models/equipamento.dart';
import '../../models/unidade.dart';
import 'cadastro_utils.dart';

class CadastroEquipamentoPage extends StatefulWidget {
	const CadastroEquipamentoPage({super.key});

	@override
	State<CadastroEquipamentoPage> createState() => _CadastroEquipamentoPageState();
}

class _CadastroEquipamentoPageState extends State<CadastroEquipamentoPage> {
	final formKey = GlobalKey<FormState>();
	final nomeController = TextEditingController();
	Unidade? unidadeSelecionada;
	final unidades = [Unidade(id: 1, nome: 'Usina principal')];

	@override
	void dispose() {
		nomeController.dispose();
		super.dispose();
	}

	void salvar() {
		if (!formKey.currentState!.validate()) return;
		final equipamento = Equipamento(
			id: 0,
			nome: nomeController.text.trim(),
			unidade: unidadeSelecionada!,
		);
		debugPrint('Equipamento: ${equipamento.nome}');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Equipamento cadastrado com sucesso!')),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Equipamento')),
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
								const SizedBox(height: 16),
								DropdownButtonFormField<Unidade>(
									  initialValue: unidadeSelecionada,
									decoration: decoracaoCampo('Unidade'),
									items: unidades
											.map((unidade) => DropdownMenuItem(
														value: unidade,
														child: Text(unidade.nome),
													))
											.toList(),
									onChanged: (valor) => setState(() => unidadeSelecionada = valor),
									validator: (valor) => valor == null ? 'Selecione a unidade' : null,
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

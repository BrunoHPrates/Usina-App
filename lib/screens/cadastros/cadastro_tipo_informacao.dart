import 'package:flutter/material.dart';

import '../../models/tipo_informacao.dart';
import '../../models/unidade_de_medida.dart';
import 'cadastro_utils.dart';

class CadastroTipoInformacaoPage extends StatefulWidget {
	const CadastroTipoInformacaoPage({super.key});

	@override
	State<CadastroTipoInformacaoPage> createState() => _CadastroTipoInformacaoPageState();
}

class _CadastroTipoInformacaoPageState extends State<CadastroTipoInformacaoPage> {
	final formKey = GlobalKey<FormState>();
	final nomeController = TextEditingController();
	final unidades = [UnidadeDeMedida(id: 1, nome: 'Litro', simbolo: 'L')];
	UnidadeDeMedida? unidadeSelecionada;

	@override
	void dispose() {
		nomeController.dispose();
		super.dispose();
	}

	void salvar() {
		if (!formKey.currentState!.validate()) return;
		final tipo = TipoInformacao(
			id: 0,
			nome: nomeController.text.trim(),
			unidadeDeMedida: unidadeSelecionada!,
		);
		debugPrint('Tipo de informação: ${tipo.nome}');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Tipo de informação cadastrado com sucesso!')),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Tipo de Informação')),
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
								DropdownButtonFormField<UnidadeDeMedida>(
									  initialValue: unidadeSelecionada,
									decoration: decoracaoCampo('Unidade de medida'),
									items: unidades
											.map((unidade) => DropdownMenuItem(
														value: unidade,
														child: Text('${unidade.nome} (${unidade.simbolo})'),
													))
											.toList(),
									onChanged: (valor) => setState(() => unidadeSelecionada = valor),
									validator: (valor) => valor == null
											? 'Selecione a unidade de medida'
											: null,
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

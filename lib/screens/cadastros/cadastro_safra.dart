import 'package:flutter/material.dart';

import '../../models/safra.dart';
import 'cadastro_utils.dart';

class CadastroSafraPage extends StatefulWidget {
	const CadastroSafraPage({super.key});

	@override
	State<CadastroSafraPage> createState() => _CadastroSafraPageState();
}

class _CadastroSafraPageState extends State<CadastroSafraPage> {
	final formKey = GlobalKey<FormState>();
	final nomeController = TextEditingController();
	DateTime? dataInicio;
	DateTime? dataFim;

	@override
	void dispose() {
		nomeController.dispose();
		super.dispose();
	}

	Future<void> selecionarDataInicio() async {
		final data = await escolherData(context, dataInicial: dataInicio);
		if (data != null) setState(() => dataInicio = data);
	}

	Future<void> selecionarDataFim() async {
		final data = await escolherData(context, dataInicial: dataFim);
		if (data != null) setState(() => dataFim = data);
	}

	void salvar() {
		if (!formKey.currentState!.validate() || dataInicio == null || dataFim == null) {
			setState(() {});
			return;
		}
		if (dataFim!.isBefore(dataInicio!)) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(content: Text('A data final deve ser posterior à inicial.')),
			);
			return;
		}
		final safra = Safra(
			id: 0,
			nomeSafra: nomeController.text.trim(),
			dataInicio: dataInicio!,
			dataFim: dataFim!,
		);
		debugPrint('Safra: ${safra.nomeSafra}');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Safra cadastrada com sucesso!')),
		);
	}

	String? validarData(DateTime? data) => data == null ? 'Selecione a data' : null;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Safra')),
			body: SingleChildScrollView(
				child: CadastroCard(
					child: Form(
						key: formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								TextFormField(
									controller: nomeController,
									decoration: decoracaoCampo('Nome da safra'),
									validator: (valor) => valor == null || valor.trim().isEmpty
											? 'Informe o nome da safra'
											: null,
								),
								const SizedBox(height: 16),
								TextFormField(
									readOnly: true,
									onTap: selecionarDataInicio,
									decoration: decoracaoCampo('Data inicial').copyWith(
										hintText: 'DD/MM/AAAA',
										suffixIcon: const Icon(Icons.calendar_month),
									),
									controller: TextEditingController(
										text: dataInicio == null ? '' : formatarData(dataInicio!),
									),
									validator: (_) => validarData(dataInicio),
								),
								const SizedBox(height: 16),
								TextFormField(
									readOnly: true,
									onTap: selecionarDataFim,
									decoration: decoracaoCampo('Data final').copyWith(
										hintText: 'DD/MM/AAAA',
										suffixIcon: const Icon(Icons.calendar_month),
									),
									controller: TextEditingController(
										text: dataFim == null ? '' : formatarData(dataFim!),
									),
									validator: (_) => validarData(dataFim),
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


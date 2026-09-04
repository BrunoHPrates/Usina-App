import 'package:flutter/material.dart';

import '../../models/equipamento.dart';
import '../../models/medicao.dart';
import '../../models/safra.dart';
import '../../models/tipo_informacao.dart';
import '../../models/unidade.dart';
import '../../models/unidade_de_medida.dart';
import 'cadastro_utils.dart';

class CadastroMedicaoPage extends StatefulWidget {
	const CadastroMedicaoPage({super.key});

	@override
	State<CadastroMedicaoPage> createState() => _CadastroMedicaoPageState();
}

class _CadastroMedicaoPageState extends State<CadastroMedicaoPage> {
	final formKey = GlobalKey<FormState>();
	final valorController = TextEditingController();
	DateTime? data;
	Safra? safraSelecionada;
	TipoInformacao? tipoSelecionado;
	Equipamento? equipamentoSelecionado;

	final safras = [
		Safra(
			id: 1,
			nomeSafra: 'Safra 2026',
			dataInicio: DateTime(2026, 1, 1),
			dataFim: DateTime(2026, 12, 31),
		),
	];
	final tipos = [
		TipoInformacao(
			id: 1,
			nome: 'Produção',
			unidadeDeMedida: UnidadeDeMedida(id: 1, nome: 'Litro', simbolo: 'L'),
		),
	];
	final equipamentos = [
		Equipamento(
			id: 1,
			nome: 'Equipamento principal',
			unidade: Unidade(id: 1, nome: 'Usina principal'),
		),
	];

	@override
	void dispose() {
		valorController.dispose();
		super.dispose();
	}

	Future<void> selecionarData() async {
		final escolhida = await escolherData(context, dataInicial: data);
		if (escolhida != null) setState(() => data = escolhida);
	}

	void salvar() {
		if (!formKey.currentState!.validate() || data == null) {
			setState(() {});
			return;
		}
		final medicao = Medicao(
			id: 0,
			safra: safraSelecionada!,
			tipoInformacao: tipoSelecionado!,
			valor: double.parse(valorController.text.replaceAll(',', '.')),
			data: data!,
			equipamento: equipamentoSelecionado!,
		);
		debugPrint('Medição: ${medicao.valor} em ${formatarData(medicao.data)}');
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Medição cadastrada com sucesso!')),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Cadastro de Medição')),
			body: SingleChildScrollView(
				child: CadastroCard(
					child: Form(
						key: formKey,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								DropdownButtonFormField<Safra>(
									  initialValue: safraSelecionada,
									decoration: decoracaoCampo('Safra'),
									items: safras
											.map((item) => DropdownMenuItem(value: item, child: Text(item.nomeSafra)))
											.toList(),
									onChanged: (valor) => setState(() => safraSelecionada = valor),
									validator: (valor) => valor == null ? 'Selecione a safra' : null,
								),
								const SizedBox(height: 16),
								DropdownButtonFormField<TipoInformacao>(
									  initialValue: tipoSelecionado,
									decoration: decoracaoCampo('Tipo de informação'),
									items: tipos
											.map((item) => DropdownMenuItem(value: item, child: Text(item.nome)))
											.toList(),
									onChanged: (valor) => setState(() => tipoSelecionado = valor),
									validator: (valor) => valor == null ? 'Selecione o tipo' : null,
								),
								const SizedBox(height: 16),
								DropdownButtonFormField<Equipamento>(
									  initialValue: equipamentoSelecionado,
									decoration: decoracaoCampo('Equipamento'),
									items: equipamentos
											.map((item) => DropdownMenuItem(value: item, child: Text(item.nome)))
											.toList(),
									onChanged: (valor) => setState(() => equipamentoSelecionado = valor),
									validator: (valor) => valor == null ? 'Selecione o equipamento' : null,
								),
								const SizedBox(height: 16),
								TextFormField(
									controller: valorController,
									keyboardType: const TextInputType.numberWithOptions(decimal: true),
									decoration: decoracaoCampo('Valor'),
									validator: (valor) {
										if (valor == null || valor.trim().isEmpty) return 'Informe o valor';
										return double.tryParse(valor.replaceAll(',', '.')) == null
												? 'Informe um valor válido'
												: null;
									},
								),
								const SizedBox(height: 16),
								TextFormField(
									readOnly: true,
									onTap: selecionarData,
									decoration: decoracaoCampo('Data').copyWith(
										hintText: 'DD/MM/AAAA',
										suffixIcon: const Icon(Icons.calendar_month),
									),
									controller: TextEditingController(
										text: data == null ? '' : formatarData(data!),
									),
									validator: (_) => data == null ? 'Selecione a data' : null,
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

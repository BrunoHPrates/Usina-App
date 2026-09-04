import 'package:flutter/material.dart';
import 'cadastros/cadastro_indicador.dart';
import 'cadastros/cadastro_equipamento.dart';
import 'cadastros/cadastro_medicao.dart';
import 'cadastros/cadastro_safra.dart';
import 'cadastros/cadastro_tipo_informacao.dart';
import 'cadastros/cadastro_unidade.dart';
import 'cadastros/cadastro_unidade_de_medida.dart';

class TelaPrincipal extends StatefulWidget {
	const TelaPrincipal({super.key});

	@override
	State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
	bool cadastroAberto = false;

	Widget montarMenu() {
		return ListView(
			padding: EdgeInsets.zero,
			children: [
				const DrawerHeader(
					child: Text(
						'Menu Principal',
						style: TextStyle(fontSize: 22),
					),
				),
				const ListTile(
					leading: Icon(Icons.home),
					title: Text('Início'),
				),
				ListTile(
					leading: const Icon(Icons.app_registration),
					title: const Text('Cadastro'),
					trailing: Icon(
						cadastroAberto ? Icons.expand_less : Icons.expand_more,
					),
					onTap: () {
						setState(() {
							cadastroAberto = !cadastroAberto;
						});
					},
				),
				if (cadastroAberto) ...[
					ListTile(
						leading: Icon(Icons.chevron_right),
						title: Text('Unidade'),
						onTap: () => abrirCadastro(const CadastroUnidadePage()),
					),
					ListTile(
						leading: Icon(Icons.chevron_right),
						title: Text('Equipamento'),
						onTap: () => abrirCadastro(const CadastroEquipamentoPage()),
					),
					ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Indicador'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroIndicadorPage(),
                ),
              );
            },
          ),
					ListTile(
						leading: Icon(Icons.chevron_right),
						title: Text('Safra'),
						onTap: () => abrirCadastro(const CadastroSafraPage()),
					),
					ListTile(
						leading: Icon(Icons.chevron_right),
						title: Text('Tipo de Informação'),
						onTap: () => abrirCadastro(const CadastroTipoInformacaoPage()),
					),
					ListTile(
						leading: Icon(Icons.chevron_right),
						title: Text('Unidade de Medida'),
						onTap: () => abrirCadastro(const CadastroUnidadeDeMedidaPage()),
					),
					ListTile(
						leading: const Icon(Icons.chevron_right),
						title: const Text('Medição'),
						onTap: () => abrirCadastro(const CadastroMedicaoPage()),
					),
				],
			],
		);
	}

	void abrirCadastro(Widget pagina) {
		Navigator.pop(context);
		Navigator.push(context, MaterialPageRoute(builder: (_) => pagina));
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Usina App'),
			),
			drawer: Drawer(
				child: montarMenu(),
			),
			body: const Center(
				child: Text('Tela Principal'),
			),
		);
	}
}


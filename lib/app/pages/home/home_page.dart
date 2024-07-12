import 'package:consulta_produto/api/parceiros/parceiro_repository_sankhya.dart';
import 'package:consulta_produto/api/produtos/produto_repository_sankhya.dart';
import 'package:consulta_produto/core/parceiros/models/parceiros.dart';
import 'package:consulta_produto/core/produtos/dto/output_produto_dto.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_codigo.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_descricao.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_marca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _tipoConsulta = 'descricao';
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();
  List<OutputProdutoDto?> items = [];

  _buscarPorCodigo(int codigo) async {
    var repository = ProdutoRepositorySankhya();
    var service = ConsultarPorCodigoService();

    var produto = await service.execute(codigo, repository);

    setState(() {
      items.clear();
      if (produto != null) {
        items.add(produto);
      }
    });
  }

  _buscarPorDescricao(String descricao) async {
    var repository = ProdutoRepositorySankhya();
    var service = ConsultarPorDescricaoService();

    var produtos = await service.execute(descricao, repository);

    setState(() {
      items.clear();
      if (produtos.isNotEmpty) {
        items = produtos;
      }
    });
  }

  _buscarPorMarca(String marca) async {
    var repository = ProdutoRepositorySankhya();
    var service = ConsultarPorMarcaService();

    var produtos = await service.execute(marca, repository);

    setState(() {
      items.clear();
      if (produtos.isNotEmpty) {
        items = produtos;
      }
    });
  }

  _onSubmit() async {
    var busca = _inputController.text;

    if (busca.isEmpty) {
      return;
    }

    if (_tipoConsulta == 'codigo') {
      _buscarPorCodigo(int.parse(busca));
    }

    if (_tipoConsulta == 'descricao') {
      _buscarPorDescricao(busca);
    }

    if (_tipoConsulta == 'marca') {
      _buscarPorMarca(busca);
    }

    _focusNode.requestFocus();
  }

  _testarParceiro() async {
    var repository = ParceiroRepositorySankhya();
    var parceiros = await repository.buscarPorNome('con');

    if (parceiros.isEmpty) return;
    for (var parceiro in parceiros) {
      print(parceiro!.nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    _testarParceiro();

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyI, control: true): () {
          setState(() {
            _tipoConsulta = 'codigo';
            _inputController.clear();
            _focusNode.requestFocus();
          });
        },
        const SingleActivator(LogicalKeyboardKey.keyD, control: true): () {
          setState(() {
            _tipoConsulta = 'descricao';
            _inputController.clear();
            _focusNode.requestFocus();
          });
        },
        const SingleActivator(LogicalKeyboardKey.keyM, control: true): () {
          setState(() {
            _tipoConsulta = 'marca';
            _inputController.clear();
            _focusNode.requestFocus();
          });
        }
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    inputForm(),
                    const SizedBox(height: 20),
                    listView(),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return items.isEmpty
        ? const Center(
            child: Text('Nenhum registro econtrado'),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(
                      "${items[index]!.codigo} - ${items[index]!.descricao}"),
                );
              },
            ),
          );
  }

  Row inputForm() {
    return Row(
      children: [
        Container(
          child: DropdownButton(
            value: _tipoConsulta,
            items: const [
              DropdownMenuItem(
                value: 'codigo',
                child: Text('Código'),
              ),
              DropdownMenuItem(
                value: 'descricao',
                child: Text('Descrição'),
              ),
              DropdownMenuItem(
                value: 'marca',
                child: Text('Marca'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _tipoConsulta = value!;
                _inputController.clear();
                _focusNode.requestFocus();
              });
            },
          ),
        ),
        Expanded(
          child: TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
            focusNode: _focusNode,
            onSubmitted: (_) {
              _onSubmit();
            },
            inputFormatters: [
              if (_tipoConsulta == 'codigo')
                FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Container(
          child: TextButton(
            onPressed: _onSubmit,
            child: const Text('Buscar'),
          ),
        )
      ],
    );
  }
}

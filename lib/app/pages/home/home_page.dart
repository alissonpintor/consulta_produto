import 'package:consulta_produto/core/produtos/dto/output_produto_dto.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_codigo.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_descricao.dart';
import 'package:consulta_produto/core/produtos/services/consultar_por_marca.dart';
import 'package:consulta_produto/mock/produto_repository_mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _tipoConsulta = 'descricao';
  var _inputController = TextEditingController();
  List<OutputProdutoDto?> items = [];

  _buscarPorCodigo(int codigo) async {
    var repository = ProdutoRepositoryMock();
    var service = ConsultarPorCodigoService();

    var produto = await service.execute(codigo, repository);

    if (produto != null) {
      setState(() {
        items.clear();
        items.add(produto);
      });
    }
  }

  _buscarPorDescricao(String descricao) async {
    var repository = ProdutoRepositoryMock();
    var service = ConsultarPorDescricaoService();

    var produtos = await service.execute(descricao, repository);

    if (produtos != null) {
      setState(() {
        items.clear();
        items = produtos;
      });
    }
  }

  _buscarPorMarca(String marca) async {
    var repository = ProdutoRepositoryMock();
    var service = ConsultarPorMarcaService();

    var produtos = await service.execute(marca, repository);

    if (produtos != null) {
      setState(() {
        items.clear();
        items = produtos;
      });
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            inputForm(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(
                        "${items[index]!.codigo} - ${items[index]!.descricao}"),
                  );
                },
              ),
            )
          ],
        ),
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
              });
            },
          ),
        ),
        Expanded(
          child: TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
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

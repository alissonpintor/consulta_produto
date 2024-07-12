import 'package:consulta_produto/core/parceiros/models/parceiros.dart';
import 'package:consulta_produto/core/parceiros/repository/parceiro_repository.dart';

class ConsultarPorNomeService {
  Future<List<Parceiros?>> execute(
    ParceiroRepository repository,
    String nome,
  ) async {
    List<Parceiros?> parceiros = await repository.buscarPorNome(nome);

    if (parceiros.isEmpty) return [];

    return parceiros;
  }
}

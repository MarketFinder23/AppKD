import 'dart:convert';
import 'package:market_finder/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/theme/theme.dart';

/// Serviço para operações relacionadas a produtos (cadastrar, atualizar e deletar).
class ProductService {
  // Base URL do backend
  final String url = AppTheme.apis.backEnd;

  // Endpoint do serviço de produtos
  final String path = '/api/products';

  /// Função para cadastrar um novo produto no backend.
  ///
  /// Aceita um objeto [ProductsInfos] como parâmetro e envia uma requisição POST.
  /// Retorna uma mensagem indicando sucesso ou erro.
  Future<String> createProduct(ProductsInfos product) async {
    try {
      // Envia uma requisição POST com os dados do produto no corpo.
      final response = await http.post(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      // Retorna a mensagem contida na resposta do backend.
      return response.body.toString();
    } catch (e) {
      // Retorna mensagem de erro em caso de exceção.
      return 'Erro ao cadastrar produto no post';
    }
  }

  /// Função para atualizar as informações de um produto existente.
  ///
  /// Aceita um objeto [ProductsInfos] como parâmetro e envia uma requisição PUT.
  /// Retorna uma mensagem indicando sucesso ou erro.
  Future<String> upadateProduct(ProductsInfos product) async {
    try {
      // Envia uma requisição PUT com os dados atualizados do produto no corpo.
      final response = await http.put(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      // Retorna a mensagem contida na resposta do backend.
      return response.body.toString();
    } catch (e) {
      // Retorna mensagem de erro em caso de exceção.
      return 'Erro ao atualizar produto no put';
    }
  }

  /// Função para deletar um produto do backend.
  ///
  /// Aceita o [id] do produto, o [email] da loja e a [password] como parâmetros.
  /// Envia uma requisição DELETE ao backend e retorna uma mensagem indicando sucesso ou erro.
  Future<String> deleteProduct(String id, String email, String password) async {
    try {
      // Envia uma requisição DELETE com os parâmetros necessários.
      final response = await http.delete(Uri.https(url, path, {
        'id': id,
        'store': email,
        'password': password,
      }));

      // Verifica o status da resposta e retorna mensagens apropriadas.
      if (response.statusCode == 200) {
        return 'Produto deletado com sucesso';
      } else {
        return 'Erro ao remover produto, tente novamente mais tarde';
      }
    } catch (e) {
      // Retorna mensagem de erro em caso de exceção.
      return 'Não foi possível remover o produto no momento';
    }
  }
}

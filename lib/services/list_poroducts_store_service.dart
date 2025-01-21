import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/product.dart';
import 'package:market_finder/models/theme/theme.dart';

/// Serviço responsável por buscar produtos de uma loja no backend.
class ListPoroductsStoreService {
  // URL base do backend
  final String url = AppTheme.apis.backEnd;

  // Caminho do endpoint
  final String path = '/api/store_list';

  /// Busca produtos da loja no backend.
  ///
  /// [text]: Texto de busca.
  /// [actualPage]: Página atual.
  /// [email]: Email para autenticação.
  /// [password]: Senha para autenticação.
  ///
  /// Retorna um mapa contendo uma lista de produtos e o total de páginas.
  Future<Map<String, dynamic>> searchProduct(
    String text,
    int actualPage,
    String email,
    String password,
  ) async {
    // Lista de produtos e total de páginas retornados pela API
    List<ProductsInfos> productsInfos = [];
    int totalPage = 0;

    try {
      // Chamada GET para o backend
      final response = await http.get(
        Uri.http(url, path, {
          'query': text, // Texto de busca
          'actualPage': actualPage.toString(), // Página atual
          'email': email, // Email de autenticação
          'password': password, // Senha de autenticação
        }),
      );

      // Verifica se a resposta é válida (código 200)
      if (response.statusCode == 200) {
        // Converte o JSON retornado para um mapa
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Extrai os produtos e o total de páginas
        final List<dynamic> productsJson = jsonData['products'];
        totalPage = jsonData['totalPage'];

        // Converte os produtos JSON em objetos `ProductsInfos`
        productsInfos =
            productsJson.map((item) => ProductsInfos.fromJson(item)).toList();
      }
    } catch (e) {
      // Em caso de erro, retorna lista vazia e total de páginas como zero
      return {
        'products': productsInfos,
        'totalPage': totalPage,
      };
    }

    // Retorna os produtos e o total de páginas
    return {
      'products': productsInfos,
      'totalPage': totalPage,
    };
  }
}

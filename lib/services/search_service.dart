import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/product.dart';
import 'package:market_finder/models/theme/theme.dart';

class SearchProductsService {
  // URL base do backend
  final String url = AppTheme.apis.backEnd;
  final String path = '/api/search_product'; // Endpoint da API para busca

  // Método para buscar produtos no backend
  Future<Map<String, dynamic>> searchProduct(
      String text, int actualPage) async {
    List<ProductsInfos> productsInfos = [];
    int totalPage = 0;

    try {
      final response = await http.get(
        Uri.https(url, path, {
          'query': text, // Texto de busca
          'actualPage': actualPage.toString(), // Número da página atual
        }),
      );

      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> productsJson = jsonData['products'] ?? [];
        totalPage = jsonData['totalPage'] ?? 0;

        // Converte os dados recebidos em objetos ProductsInfos
        productsInfos =
            productsJson.map((item) => ProductsInfos.fromJson(item)).toList();
      } else {
        // Caso a resposta não seja bem-sucedida, lança uma exceção
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (e) {
      // Log de erro pode ser adicionado aqui para depuração
      throw Exception('Erro ao buscar produtos: $e');
    }

    return {
      'products': productsInfos,
      'totalPage': totalPage,
    };
  }
}

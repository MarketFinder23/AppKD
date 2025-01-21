import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/theme/theme.dart';

class LoginServices {
  final String url = AppTheme.apis.backEnd;

  // Define o caminho do endpoint para a requisição de login
  final String path = '/api/login';

  Future<Map<String, dynamic>> tryLogin(
    String email,
    String password,
  ) async {
    // Função que envia as credenciais de login para a API e espera uma resposta
    try {
      final response = await http.post(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      // Verifica o código de status e tenta decodificar a resposta se for válido
      if (response.statusCode == 201 || response.statusCode == 400) {
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          return {
            'message': data['message'] ?? 'Mensagem não fornecida',
            'isUser': data['isUser'],
          };
        } catch (e) {
          // Trata respostas que não podem ser decodificadas
          return {'message': 'Resposta inválida do servidor', 'isUser': null};
        }
      }
    } catch (e) {
      // Tratamento de erros relacionados à rede e outros tipos de exceções
      if (e is http.ClientException) {
        return {'message': 'Erro de conexão com o servidor', 'isUser': null};
      } else {
        return {'message': 'Erro desconhecido: $e', 'isUser': null};
      }
    }

    // Retorno padrão para casos inesperados
    return {'message': 'Erro inesperado no login', 'isUser': null};
  }
}

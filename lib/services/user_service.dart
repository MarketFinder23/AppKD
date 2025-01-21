import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String url = AppTheme.apis.backEnd;

  // kIsWeb
  // ? 'localhost:3000'
  // : '10.0.2.2:3000'; //Verifica se o emulador é WEB ou MOBILE para definir a url
  final String path =
      '/api/user'; //Define o pacote especifico que será chamado na API

  Future<String> createUser(UserInfos userInfos) async {
    /* --- Envia as informações do usuario e espera receber sucefully --- */
    try {
      final response = await http.post(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String message = responseData['message'];

      if (message == 'successfully') {
        saveUserInfos(userInfos);
      }

      return message;
    } catch (e) {
      return 'Erro CATCH';
    }
  }

  //Faz a atualização de dados no banco0 de dados
  Future<String> upadateUser(UserInfos userInfos) async {
    /* --- Envia as informações do usuario e espera receber sucefully --- */
    try {
      final response = await http.put(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String message = responseData['message'];

      if (message == 'successfully') {
        saveUserInfos(userInfos);
      }

      return message;
    } catch (e) {
      return 'Erro CATCH';
    }
  }

  //Faz uma busca no cash do aparelho pelas informações caso não encontre busca no banco de dados
  Future<UserInfos> getUser() async {
    final storage = await SharedPreferences.getInstance();
    String? userJson = storage.getString('userInfos');
    if (userJson != null) {
      return UserInfos.fromJson(jsonDecode(userJson));
    } else {
      try {
        final response = await http.get(
          Uri.https(url, path),
        );
        if (response.statusCode == 200) {
          UserInfos userInfos = UserInfos.fromJson(jsonDecode(response.body));
          saveUserInfos(userInfos);
          return userInfos;
        } else {
          return UserInfos(
              name: '',
              phoneNumber: '',
              email: '',
              cpf: '',
              password: '',
              addressID: '');
        }
      } catch (e) {
        return UserInfos(
            name: '',
            phoneNumber: '',
            email: '',
            cpf: '',
            password: '',
            addressID: '');
      }
    }
  }

  // Salva os dados em cash para resgate masi rapido dos dados
  Future<void> saveUserInfos(UserInfos userInfos) async {
    final storage = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userInfos.toJson());
    await storage.setString('userInfos', userJson);
    await storage.setBool('isUser', true);
    await storage.setString('email', userInfos.email.toString());
    await storage.setString('password', userInfos.password.toString());
  }
}

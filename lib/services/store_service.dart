import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/models/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  final String url = AppTheme.apis.backEnd;

  // kIsWeb
  // ? 'localhost:3000'
  // : '10.0.2.2:3000'; //Verifica se o emulador é WEB ou MOBILE para definir a url
  final String path =
      '/api/store'; //Define o pacote especifico que será chamado na API

  Future<String> createStore(StoreInfos storeInfos) async {
    // Envia as informações da loja e espera receber sucefully
    try {
      final response = await http.post(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(storeInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String message = responseData['message'];

      if (message == 'successfully') {
        saveStoresInfos(storeInfos);
      }
      return message;
    } catch (e) {
      return 'Erro CATCH';
    }
  }

  //Faz a atualização de dados no banco0 de dados
  Future<String> upadateStore(StoreInfos storeInfos) async {
    /* --- Envia as informações do usuario e espera receber sucefully --- */
    try {
      final response = await http.put(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(storeInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String message = responseData['message'];

      if (message == 'successfully') {
        saveStoresInfos(storeInfos);
      }

      return message;
    } catch (e) {
      return 'Erro CATCH';
    }
  }

  //Faz uma busca no cash do aparelho pelas informações caso não encontre busca no banco de dados
  Future<StoreInfos> getStore() async {
    final storage = await SharedPreferences.getInstance();
    String? storeJson = storage.getString('storeInfos');
    if (storeJson != null) {
      return StoreInfos.fromJson(jsonDecode(storeJson));
    } else {
      try {
        final response = await http.get(
          Uri.https(url, path),
        );
        if (response.statusCode == 200) {
          StoreInfos storeInfos =
              StoreInfos.fromJson(jsonDecode(response.body));
          saveStoresInfos(storeInfos);
          return storeInfos;
        } else {
          return StoreInfos(
              fantasiName: '',
              corporateReason: '',
              phoneNumber: '',
              whatsapp: '',
              email: '',
              cnpj: '',
              password: '',
              addressID: '');
        }
      } catch (e) {
        return StoreInfos(
            fantasiName: '',
            corporateReason: '',
            phoneNumber: '',
            whatsapp: '',
            email: '',
            cnpj: '',
            password: '',
            addressID: '');
      }
    }
  }

  // Salva os dados em cash para resgate masi rapido dos dados
  Future<void> saveStoresInfos(StoreInfos storeInfos) async {
    final storage = await SharedPreferences.getInstance();
    String storeJson = jsonEncode(storeInfos.toJson());
    await storage.setString('storeInfos', storeJson);
    await storage.setBool('isUser', false);
    await storage.setString('email', storeInfos.email.toString());
    await storage.setString('password', storeInfos.password.toString());
  }
}

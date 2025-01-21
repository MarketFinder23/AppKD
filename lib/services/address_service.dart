import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  final String url = AppTheme.apis.backEnd;

  // kIsWeb
  // ? 'localhost:3000'
  // : '10.0.2.2:3000'; //Verifica se o emulador é WEB ou MOBILE para definir a url
  final String path =
      '/api/address'; //Define o pacote especifico que será chamado na API

  Future<Map<String, dynamic>> createAddress(AddressInfos addressInfos) async {
    // Envia as informações do endereço e espera receber o id númerico e uma menssagem como retorno
    try {
      final response = await http.post(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(addressInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      String message = responseData['message'];
      String id = responseData['id'];

      if (message == 'successfully') {
        addressInfos.id = id;
        saveAddressInfos(addressInfos);
      }
      return {'message': message, 'id': id};
    } catch (e) {
      return {'message': e, 'id': -1};
    }
  }

  //Faz a atualização de dados no banco0 de dados
  Future<String> upadateaddress(AddressInfos addressInfos) async {
    /* --- Envia as informações do usuario e espera receber sucefully --- */
    try {
      final response = await http.put(
        Uri.https(url, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(addressInfos.toJson()),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      String message = responseData['message'];

      if (message == 'successfully') {
        saveAddressInfos(addressInfos);
      }

      return message;
    } catch (e) {
      return 'Erro CATCH';
    }
  }

  //Faz uma busca no cash do aparelho pelas informações caso não encontre busca no banco de dados
  Future<AddressInfos> getAddress() async {
    final storage = await SharedPreferences.getInstance();
    String? addressJson = storage.getString('addressInfos');
    if (addressJson != null) {
      return AddressInfos.fromJson(jsonDecode(addressJson));
    } else {
      try {
        final response = await http.get(
          Uri.https(url, path),
        );
        if (response.statusCode == 200) {
          AddressInfos addressInfos =
              AddressInfos.fromJson(jsonDecode(response.body));
          saveAddressInfos(addressInfos);
          return addressInfos;
        } else {
          // Se a resposta não for 200, retorna um objeto vazio
          return AddressInfos(
            cep: '',
            city: '',
            neighborhood: '',
            street: '',
            number: '',
            complement: '',
            id: '',
          );
        }
      } catch (e) {
        return AddressInfos(
          cep: '',
          city: '',
          neighborhood: '',
          street: '',
          number: '',
          complement: '',
          id: '',
        );
      }
    }
  }

  // Salva os dados em cash para resgate masi rapido dos dados
  Future<void> saveAddressInfos(AddressInfos addressInfos) async {
    final storage = await SharedPreferences.getInstance();
    String addresJson = jsonEncode(addressInfos.toJson());
    await storage.setString('addressInfos', addresJson);
  }
}

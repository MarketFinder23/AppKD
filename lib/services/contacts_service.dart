import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_finder/models/theme/theme.dart';
import 'package:geolocator/geolocator.dart';

class ContactsService {
  // URL base do backend definida no tema
  final String url = AppTheme.apis.backEnd;

  // Caminho do endpoint para busca de contatos
  final String path = '/api/contacts';

  // Função que busca informações de contatos do backend com base no ID do produto
  Future<Map<String, dynamic>> contactsInfos(String id) async {
    try {
      // Obtemos a localização atual do usuário
      Position position = await getUserLocation();

      // Pegamos as coordenadas de latitude e longitude
      String lat = position.latitude.toString();
      String lng = position.longitude.toString();

      // Realiza a requisição GET ao servidor
      final response = await http.get(
        Uri.https(url, path, {
          'id': id, // ID do produto como parâmetro
          'lat': lat, // Latitude do usuário
          'lng': lng, // Longitude do usuário
        }),
      );

      // Verifica o status da resposta
      if (response.statusCode == 200) {
        // Converte o corpo da resposta em JSON e retorna os dados
        return jsonDecode(response.body);
      } else {
        // Retorna um objeto padrão em caso de erro no status
        return {'result': 'fail'};
      }
    } catch (e) {
      // Trata exceções e retorna um objeto padrão em caso de erro
      return {'result': 'fail', 'error': e.toString()};
    }
  }

  // Função que obtém a localização atual do usuário
  Future<Position> getUserLocation() async {
    // Verifica se os serviços de localização estão ativados
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Os serviços de localização estão desativados.');
    }

    // Verifica e solicita permissões de localização
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissões de localização foram negadas.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permissões de localização foram permanentemente negadas.');
    }

    // Obtém a posição atual do usuário com configurações personalizadas
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Alta precisão
        distanceFilter: 10, // Atualizar localização a cada 10 metros
      ),
    );

    // Retorna a posição atual do usuário
    return position;
  }
}

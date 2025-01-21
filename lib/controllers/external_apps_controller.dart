import 'package:url_launcher/url_launcher.dart';

class ExternalAppsController {
  // Função de ligação por telefone
  void calltoStore(String phoneNumber) async {
    final Uri phone = Uri(scheme: 'tel', path: phoneNumber);
    if (await launchUrl(phone)) {
      await launchUrl(phone);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Email de contato para a loja
  void emailtoStore(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Assunto do Email&body=Este é o corpo do email',
    );

    if (await launchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  // Whatsapp de contato para a loja
  void whatstoStore(String phoneNumber) async {
    const String message = 'Olá mundo!!!';

    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      queryParameters: {'text': message},
    );

    if (await launchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $whatsappUri';
    }
  }

  // GPS para localização da loja
  void maptoStore(String location) async {
    final query = Uri.encodeComponent(location);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$query';

    if (await launchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}

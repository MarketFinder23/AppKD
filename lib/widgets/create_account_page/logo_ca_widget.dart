import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/logo.dart'; // Importa o widget de logotipo reutilizável
import 'package:market_finder/controllers/create_account_controller.dart'; // Importa o controlador para o processo de criação de conta
import 'package:market_finder/models/theme/theme.dart'; // Importa o tema personalizado

// Widget para exibir um logotipo sem nome na página de criação de conta
class LogoCaPage extends GetView<CreateAccountController> {
  const LogoCaPage({super.key}); // Componente sem estado com chave opcional

  @override
  Widget build(BuildContext context) {
    return Logo(
      svg: AppTheme
          .logos.logoNoName, // Logotipo SVG definido no tema personalizado
      height: Get.height *
          0.1, // Define a altura do logotipo como 10% da altura da tela
    );
  }
}

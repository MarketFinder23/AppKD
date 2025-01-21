import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/controllers/login_page_controller.dart';

// Botão para navegação à tela de criação de conta
class CreateAccountButtonLoginPage extends GetView<LoginPageController> {
  const CreateAccountButtonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      text: 'CRIAR CONTA', // Texto do botão
      onPressed: () {
        Get.put(
            CreateAccountController()); // Inicializa o controlador de criação de conta
        controller.navegationPage(context,
            '/create_account/select_user'); // Navega para a tela de criação de conta
      },
      width: Get.width * 0.4, // Define a largura do botão
      height: Get.height * 0.05, // Define a altura do botão
      style: ButtonStyleType.neutral, // Estilo do botão
    );
  }
}

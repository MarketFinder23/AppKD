import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/login_page_controller.dart';

// Botão "Entrar" na página de login
class LoginButtonLoginPage extends GetView<LoginPageController> {
  const LoginButtonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      text: 'ENTRAR', // Texto exibido no botão
      onPressed: () {
        controller.tryToLogin(
            context); // Chama a função de tentativa de login do controlador
      },
      width: Get.width * 0.4, // Define a largura do botão
      height: Get.height * 0.05, // Define a altura do botão
      style: ButtonStyleType.neutral, // Define o estilo do botão
    );
  }
}

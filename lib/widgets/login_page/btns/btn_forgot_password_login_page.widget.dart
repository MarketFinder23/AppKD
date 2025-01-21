import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_underline.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import '../../../deveatualizar.dart'; // Import para futura conexão com a tela "Esqueci minha senha"

// Botão "Esqueci Minha Senha" na página de login
class ForgotPasswordButtonLoginPage extends GetView<LoginPageController> {
  const ForgotPasswordButtonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonUnderline(
      onPressed: () {}, // Ação ainda não definida para recuperação de senha
      text: 'esqueci minha senha', // Texto exibido no botão
      fontSize:
          Get.height * 0.018, // Tamanho da fonte ajustado à altura da tela
    );
  }
}

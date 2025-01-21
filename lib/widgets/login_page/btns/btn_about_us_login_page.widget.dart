import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_underline.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import '../../../deveatualizar.dart'; // Import para futura conexão com uma tela externa "Sobre Nós"

// Botão "Sobre Nós" na página de login, utilizando GetView para acessar o controlador
class AboutUsButtonLoginPage extends GetView<LoginPageController> {
  const AboutUsButtonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.01),
      child: TextButtonUnderline(
        onPressed: () {}, // Botão ainda sem função definida
        text: 'sobre nós', // Texto exibido no botão
        fontSize:
            Get.height * 0.02, // Tamanho da fonte baseado na altura da tela
      ),
    );
  }
}

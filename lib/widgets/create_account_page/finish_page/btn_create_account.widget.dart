import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/create_account_controller.dart';

// Widget para exibir o botão de criar conta
class BtnCreateAccount extends GetView<CreateAccountController> {
  // Botão que chama a função de criação de conta no controlador
  const BtnCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      onPressed: () {
        // Chama o método do controlador para criar a conta
        controller.createAcount(context);
      },
      text: 'CONTINUAR', // Texto exibido no botão
      style: ButtonStyleType.neutral, // Estilo do botão
      height: Get.height * 0.08, // Altura proporcional à tela
      width: Get.width * 0.5, // Largura proporcional à tela
    );
  }
}

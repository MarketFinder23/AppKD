import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/create_account_controller.dart';

// Botão para selecionar a opção "Usuário" no processo de criação de conta
class BtnUserOption extends GetView<CreateAccountController> {
  const BtnUserOption({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      onPressed: () {
        // Define o tipo de usuário como "Usuário" (não loja)
        controller.typeUser(true);
        // Navega para a página de preenchimento de nome
        Navigator.of(context).pushNamed('/create_account/name');
      },
      text: 'Procuro produtos!', // Texto exibido no botão
      style: ButtonStyleType.neutral, // Estilo neutro para o botão
      height: Get.height * 0.1, // Altura proporcional à tela
      width: Get.width * 0.7, // Largura proporcional à tela
    );
  }
}

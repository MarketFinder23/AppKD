import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/create_account_controller.dart';

// Botão para selecionar a opção "Loja" no processo de criação de conta
class BtnStoreOption extends GetView<CreateAccountController> {
  const BtnStoreOption({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      onPressed: () {
        // Define o tipo de usuário como "Loja"
        controller.typeUser(false);
        // Navega para a página de preenchimento de nome
        Navigator.of(context).pushNamed('/create_account/name');
      },
      text: 'Tenho uma loja!', // Texto exibido no botão
      style: ButtonStyleType.neutral, // Estilo neutro para o botão
      height: Get.height * 0.1, // Altura proporcional à tela
      width: Get.width * 0.7, // Largura proporcional à tela
    );
  }
}

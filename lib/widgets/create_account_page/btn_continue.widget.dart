import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/create_account_controller.dart';

// Botão de continuação para a página de criação de conta
class ContinueButtonCaPage extends GetView<CreateAccountController> {
  // Chave do formulário associada à página atual
  final GlobalKey<FormState> formKeyCa;
  // Nome da próxima página no fluxo de criação de conta
  final String nextPage;

  const ContinueButtonCaPage({
    super.key,
    required this.formKeyCa,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return TextButtonRounded(
      onPressed: () {
        // Salva o formulário e navega para a próxima página
        controller.saveForm(context, formKeyCa, nextPage);
      },
      text: 'CONFIRMAR', // Texto exibido no botão
      style: ButtonStyleType.neutral, // Estilo neutro para o botão
      height: Get.height * 0.05, // Altura proporcional à tela
      width: Get.width * 0.55, // Largura proporcional à tela
    );
  }
}

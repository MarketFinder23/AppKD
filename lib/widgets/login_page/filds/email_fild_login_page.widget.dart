import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Campo de texto para entrada de email na página de login
class EmailFildLoginPage extends GetView<LoginPageController> {
  const EmailFildLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Define a largura do campo
      height: Get.height * 0.08, // Define a altura do campo
      keyboardType: TextInputType.emailAddress, // Tipo de teclado para email
      description: 'nome@email.com', // Placeholder do campo
      validator: (text) =>
          controller.emailValidate(text), // Função de validação de email
      text: '', // Texto inicial vazio
      icon: AppTheme.icons.letter, // Ícone associado ao campo de texto
      mask: MaskTextInputFormatter(), // Máscara para o campo de entrada
      controller: controller.emailController, // Controlador do campo de email
      onChanged: (value) =>
          controller.resetValidation(), // Reseta a validação ao alterar o valor
      onSaved: (value) {}, // Função ao salvar (ainda sem implementação)
      readOnly: false, // Campo não é apenas leitura
    );
  }
}

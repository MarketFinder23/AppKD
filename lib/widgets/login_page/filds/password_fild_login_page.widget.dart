import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Campo de texto para entrada de senha na página de login
class PasswordFildLoginPage extends GetView<LoginPageController> {
  const PasswordFildLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Define a largura do campo
      height: Get.height * 0.06, // Define a altura do campo
      keyboardType: TextInputType.text, // Tipo de teclado padrão (texto)
      description: 'digite sua senha', // Placeholder do campo
      validator: (text) =>
          controller.passwordValidate(text), // Função de validação de senha
      text: '', // Texto inicial vazio
      icon: AppTheme.icons.padlock, // Ícone associado ao campo (cadeado)
      mask: MaskTextInputFormatter(), // Máscara para o campo de entrada
      controller:
          controller.passwordController, // Controlador do campo de senha
      onChanged: (value) =>
          controller.resetValidation(), // Reseta a validação ao alterar o valor
      onSaved: (value) {}, // Função ao salvar (ainda sem implementação)
      readOnly: false, // Campo não é apenas leitura
    );
  }
}

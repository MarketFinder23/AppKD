import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Widget para exibir campos de entrada de texto para Nome ou Razão Social/Nome Fantasia
class TextFildCaName extends GetView<CreateAccountController> {
  const TextFildCaName({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyCaName, // Chave do formulário para validação
      autovalidateMode: AutovalidateMode
          .onUserInteraction, // Validação automática em interação
      child: controller.isUser
          ? _buildSingleField(
              // Campo único para o nome (usuário)
              label: '',
              hint: 'Digite seu nome...', // Placeholder
              icon: AppTheme.icons.person, // Ícone de pessoa
              controller: controller.nameController, // Controlador do texto
              validator: (text) =>
                  controller.validate(ValidationMode.text, text), // Validação
              onSaved: (text) {
                controller.user.name =
                    text!; // Salva o nome no modelo de usuário
              },
            )
          : Column(
              // Campos para loja (Razão Social e Nome Fantasia)
              children: [
                _buildSingleField(
                  label: 'Razão Social',
                  hint: '',
                  controller: controller.socialNameController,
                  validator: (text) =>
                      controller.validate(ValidationMode.text, text),
                  onSaved: (text) {
                    controller.store.corporateReason = text!;
                  },
                ),
                _buildSingleField(
                  label: 'Nome Fantasia',
                  hint: '',
                  controller: controller.fantasiNameController,
                  validator: (text) =>
                      controller.validate(ValidationMode.text, text),
                  onSaved: (text) {
                    controller.store.fantasiName = text!;
                  },
                ),
              ],
            ),
    );
  }

  // Método auxiliar para construir um campo de texto reutilizável
  Widget _buildSingleField({
    required String label, // Rótulo do campo
    required String hint, // Placeholder do campo
    required TextEditingController controller, // Controlador do texto
    required String? Function(String?) validator, // Validação do texto
    required void Function(String?) onSaved, // Salvar o valor do texto
    IconData? icon, // Ícone opcional
  }) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Largura proporcional à tela
      keyboardType: TextInputType.name, // Tipo de entrada: texto (nome)
      description: hint, // Placeholder
      validator: validator, // Função de validação
      text: label, // Rótulo do campo
      height: Get.height * 0.1, // Altura proporcional à tela
      icon: icon, // Ícone associado
      mask: MaskTextInputFormatter(), // Máscara de entrada
      controller: controller, // Controlador do campo
      onChanged: (text) {}, // Função para alterações no texto
      onSaved: onSaved, // Função para salvar o texto
      readOnly: false, // Campo editável
    );
  }
}

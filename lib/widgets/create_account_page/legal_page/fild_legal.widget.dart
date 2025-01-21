import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Widget que exibe o formulário de entrada para CPF ou CNPJ
class FildsCaLegal extends GetView<CreateAccountController> {
  const FildsCaLegal({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário para documentos legais (CPF ou CNPJ)
    return Form(
      key: controller.formKeyCaLegal, // Chave do formulário para validação
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // Validação em tempo real
      child: _buildLegalField(
        label: controller.isUser ? 'CPF' : 'CNPJ', // Rótulo dinâmico
        mask: controller.isUser
            ? '###.###.###-##' // Máscara para CPF
            : '##.###.###/####-##', // Máscara para CNPJ
        validator: (text) => controller.validate(
          // Validação com base no tipo de usuário
          controller.isUser ? ValidationMode.cpf : ValidationMode.cnpj,
          text,
        ),
        controller: controller.isUser
            ? controller.cpfController // Controlador para CPF
            : controller.cnpjController, // Controlador para CNPJ
        onSaved: (text) {
          // Salva o valor no modelo correspondente (usuário ou loja)
          if (controller.isUser) {
            controller.user.cpf = text!;
          } else {
            controller.store.cnpj = text!;
          }
        },
      ),
    );
  }

  // Método auxiliar para criar o campo de entrada de texto para CPF/CNPJ
  Widget _buildLegalField({
    required String label, // Rótulo do campo
    required String mask, // Máscara para formatação
    required String? Function(String?) validator, // Função de validação
    required TextEditingController controller, // Controlador do texto
    required void Function(String?) onSaved, // Função para salvar o valor
  }) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Largura proporcional à tela
      height: Get.height * 0.1, // Altura proporcional à tela
      keyboardType: TextInputType.number, // Tipo de entrada numérica
      description: '', // Sem descrição adicional
      text: label, // Rótulo do campo (CPF ou CNPJ)
      icon: null, // Sem ícone
      mask: MaskTextInputFormatter(
        mask: mask, // Define a máscara para CPF ou CNPJ
        filter: {"#": RegExp(r'[0-9]')}, // Permite apenas números
      ),
      onChanged: (text) {}, // Função chamada ao alterar o texto
      controller: controller, // Controlador do campo
      validator: validator, // Função de validação
      onSaved: onSaved, // Função para salvar o texto
      readOnly: false, // Campo editável
    );
  }
}

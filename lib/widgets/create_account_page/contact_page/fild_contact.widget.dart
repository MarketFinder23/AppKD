import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Widget que exibe o formulário de contatos para o usuário/loja
class FildsCaContact extends GetView<CreateAccountController> {
  const FildsCaContact({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário para os contatos
    return Form(
      key: controller.formKeyCaContact, // Chave do formulário para validação
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // Validação automática ao digitar
      child: Column(
        children: [
          // Campo de texto para e-mail
          _buildTextField(
            label: 'E-mail',
            controller: controller.emailController, // Controlador para o e-mail
            icon: AppTheme.icons.letter, // Ícone do campo
            keyboardType: TextInputType
                .emailAddress, // Define o tipo de entrada como e-mail
            mask: MaskTextInputFormatter(), // Máscara vazia para e-mail
            validator: (text) => controller.validate(
                ValidationMode.email, text), // Validação de e-mail
            onSaved: (text) {
              // Salva o valor do e-mail no modelo correspondente (usuário ou loja)
              if (controller.isUser) {
                controller.user.email = text!;
              } else {
                controller.store.email = text!;
              }
            },
          ),
          // Campo de texto para WhatsApp
          _buildTextField(
            label: 'WhatsApp',
            controller:
                controller.whatsController, // Controlador para o WhatsApp
            icon: AppTheme.icons.whatsapp, // Ícone do campo
            keyboardType: TextInputType.number, // Tipo de entrada numérica
            mask: MaskTextInputFormatter(
              mask: '(##) #########', // Máscara para número de telefone
              filter: {"#": RegExp(r'[0-9]')}, // Permite apenas números
            ),
            validator: (text) => controller.validate(
                ValidationMode.phone, text), // Validação de telefone
            onSaved: (text) {
              // Salva o valor do WhatsApp no modelo correspondente
              if (controller.isUser) {
                controller.user.phoneNumber = text!;
              } else {
                controller.store.phoneNumber = text!;
              }
            },
          ),
          // Campo de texto para telefone adicional (apenas para lojas)
          if (!controller.isUser) // Renderiza apenas se o usuário for uma loja
            _buildTextField(
              label: 'Telefone',
              controller: controller
                  .phoneController, // Controlador para telefone adicional
              icon: AppTheme.icons.phone, // Ícone do campo
              keyboardType: TextInputType.number, // Tipo de entrada numérica
              mask: MaskTextInputFormatter(
                mask: '(##) #########', // Máscara para número de telefone
                filter: {"#": RegExp(r'[0-9]')}, // Permite apenas números
              ),
              validator: (text) => controller.validate(
                  ValidationMode.phone, text), // Validação de telefone
              onSaved: (text) {
                // Salva o valor do telefone no modelo da loja
                controller.store.whatsapp = text!;
              },
            ),
        ],
      ),
    );
  }

  // Método auxiliar para criar um campo de texto
  Widget _buildTextField({
    required String label, // Rótulo do campo
    required TextEditingController controller, // Controlador do texto
    required IconData? icon, // Ícone do campo
    required TextInputType keyboardType, // Tipo de entrada
    required MaskTextInputFormatter mask, // Máscara de formatação
    required String? Function(String?) validator, // Função de validação
    required void Function(String?) onSaved, // Função para salvar o valor
  }) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Largura proporcional à tela
      height: Get.height * 0.1, // Altura proporcional à tela
      keyboardType: keyboardType, // Tipo de entrada (numérico ou texto)
      description: '', // Sem descrição adicional
      text: label, // Rótulo do campo
      icon: icon, // Ícone do campo
      mask: mask, // Máscara de entrada
      controller: controller, // Controlador do texto
      validator: validator, // Função de validação
      onChanged: (text) {}, // Função chamada ao alterar o texto
      onSaved: onSaved, // Função para salvar o valor
      readOnly: false, // Campo editável
    );
  }
}

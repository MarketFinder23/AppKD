import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Campos de entrada para senhas no processo de criação de conta
class FildsCaPassword extends GetView<CreateAccountController> {
  const FildsCaPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário contendo os campos de senha
    return Form(
      key: controller.formKeyCaPassword, // Chave do formulário para validação
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // Validação em tempo real
      child: Column(
        children: [
          // Campo de entrada para a senha
          _buildPasswordField(
            label: 'Senha',
            controller: controller.passwordController, // Controlador do campo
            validator: (text) =>
                controller.validate(ValidationMode.password, text), // Validação
            onSaved: (text) {
              // Salva a senha na instância de usuário ou loja
              if (controller.isUser) {
                controller.user.password = text!;
              } else {
                controller.store.password = text!;
              }
            },
          ),
          // Campo de entrada para confirmar a senha
          _buildPasswordField(
            label: 'Confirmar Senha',
            controller:
                controller.confirmPassController, // Controlador do campo
            validator: (text) => controller.validate(
                ValidationMode.confirmPassword, text), // Validação
          ),
        ],
      ),
    );
  }

  // Método para criar campos de entrada reutilizáveis
  Widget _buildPasswordField({
    required String label, // Rótulo do campo
    required TextEditingController controller, // Controlador do campo
    required String? Function(String?) validator, // Função de validação
    void Function(String?)? onSaved, // Função para salvar o valor
  }) {
    return TextFildUnderline(
      width: Get.width * 0.8, // Largura do campo, proporcional à tela
      height: Get.height * 0.1, // Altura do campo, proporcional à tela
      keyboardType: TextInputType.text, // Tipo de entrada: texto
      description: '', // Sem descrição adicional
      validator: validator, // Validação do texto
      text: label, // Rótulo exibido no campo
      icon: null, // Sem ícone associado
      controller: controller, // Controlador do campo
      onChanged: (text) {}, // Função chamada ao alterar o texto
      onSaved: (text) => onSaved, // Função chamada ao salvar o texto
      readOnly: false, // Campo editável
      mask: MaskTextInputFormatter(), // Máscara para formatação do texto
    );
  }
}

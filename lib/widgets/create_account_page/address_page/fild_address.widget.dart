import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Widget que exibe o formulário de endereço na criação de conta
class FildsCaAddress extends GetView<CreateAccountController> {
  const FildsCaAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário para os dados de endereço
    return Form(
      key: controller.formKeyCaAddress, // Chave do formulário para validação
      autovalidateMode: AutovalidateMode
          .onUserInteraction, // Validação automática ao interagir
      child: Column(
        children: [
          // Campo de texto para a cidade
          _buildTextField(
            label: 'Cidade',
            controller: controller.cityController, // Controlador do texto
            keyboardType: TextInputType.name, // Tipo de entrada: texto
            validator: (text) => controller.validate(
                ValidationMode.text, text), // Validação de texto
            onSaved: (text) {
              controller.address.city =
                  text!; // Salva a cidade no modelo de endereço
            },
          ),
          // Linha contendo os campos de bairro e CEP
          _buildRow([
            _buildTextField(
              label: 'Bairro',
              controller:
                  controller.neighborhoodController, // Controlador do bairro
              width: Get.width * 0.4, // Largura do campo ajustada
              keyboardType: TextInputType.name, // Tipo de entrada: texto
              validator: (text) => controller.validate(
                  ValidationMode.text, text), // Validação de texto
              onSaved: (text) {
                controller.address.neighborhood = text!; // Salva o bairro
              },
            ),
            _buildTextField(
              label: 'CEP',
              controller: controller.cepController, // Controlador do CEP
              width: Get.width * 0.3, // Largura do campo ajustada
              keyboardType: TextInputType.number, // Tipo de entrada: numérico
              mask: MaskTextInputFormatter(
                mask: '#####-###', // Máscara para formato de CEP
                filter: {"#": RegExp(r'[0-9]')}, // Apenas números permitidos
              ),
              validator: (text) => controller.validate(
                  ValidationMode.cep, text), // Validação de CEP
              onSaved: (text) {
                controller.address.cep = text!; // Salva o CEP
              },
            ),
          ]),
          // Linha contendo os campos de rua e número
          _buildRow([
            _buildTextField(
              label: 'Rua',
              controller: controller.streetController, // Controlador da rua
              width: Get.width * 0.5, // Largura do campo ajustada
              keyboardType: TextInputType.name, // Tipo de entrada: texto
              validator: (text) => controller.validate(
                  ValidationMode.text, text), // Validação de texto
              onSaved: (text) {
                controller.address.street = text!; // Salva a rua
              },
            ),
            _buildTextField(
              label: 'Número',
              controller:
                  controller.houseNumberController, // Controlador do número
              width: Get.width * 0.2, // Largura do campo ajustada
              keyboardType: TextInputType.number, // Tipo de entrada: numérico
              validator: (text) => controller.validate(
                  ValidationMode.number, text), // Validação de número
              onSaved: (text) {
                controller.address.number = text!; // Salva o número
              },
            ),
          ]),
          // Campo de texto para o complemento
          _buildTextField(
            label: 'Complemento',
            controller:
                controller.complementController, // Controlador do complemento
            keyboardType: TextInputType.name, // Tipo de entrada: texto
            validator: (text) => controller.validate(
                ValidationMode.text, text), // Validação de texto
            onSaved: (text) {
              controller.address.complement = text!; // Salva o complemento
            },
          ),
        ],
      ),
    );
  }

  // Método auxiliar para criar campos de texto
  Widget _buildTextField({
    required String label, // Rótulo do campo
    required TextEditingController controller, // Controlador do texto
    required TextInputType keyboardType, // Tipo de entrada
    required String? Function(String?) validator, // Função de validação
    required void Function(String?) onSaved, // Função para salvar o valor
    MaskTextInputFormatter? mask, // Máscara opcional para o campo
    double? width, // Largura opcional do campo
  }) {
    return TextFildUnderline(
      width: width ?? Get.width * 0.8, // Largura padrão
      height: Get.height * 0.1, // Altura proporcional à tela
      keyboardType: keyboardType, // Tipo de entrada
      description: '', // Sem descrição adicional
      text: label, // Rótulo do campo
      icon: null, // Sem ícone
      mask: mask ?? MaskTextInputFormatter(), // Máscara padrão (vazia)
      onChanged: (text) {}, // Nenhuma ação ao alterar
      controller: controller, // Controlador do texto
      validator: validator, // Função de validação
      onSaved: onSaved, // Função para salvar o valor
      readOnly: false, // Campo editável
    );
  }

  // Método auxiliar para criar uma linha com múltiplos campos
  Widget _buildRow(List<Widget> children) {
    return SizedBox(
      width: Get.width * 0.8, // Largura da linha ajustada
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Espaçamento uniforme entre os campos
        children: children, // Lista de widgets filhos
      ),
    );
  }
}

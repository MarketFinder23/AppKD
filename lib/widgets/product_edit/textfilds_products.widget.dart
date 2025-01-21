import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/components/buttons/upload_img.dart';
import 'package:market_finder/components/checkbox.dart';
import 'package:market_finder/components/text_fild/textfild_rounded.dart';
import 'package:market_finder/controllers/product_edit_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Formulário para edição ou cadastro de produto
class TextEditProducts extends GetView<CadProductController> {
  const TextEditProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey, // Chave global para validação do formulário
      child: Column(
        children: [
          /// Seção: Nome e Valor do Produto
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Campo para nome do produto
                TextFildRounded(
                  readOnly: false,
                  heigth: Get.height * 0.055,
                  width: Get.width * 0.6,
                  description: 'Nome do Produto',
                  keyboardType: TextInputType.text,
                  text: 'Nome do produto',
                  validator: (text) {
                    return controller.validate(ValidationMode.text, text);
                  },
                  onChanged: (text) {
                    controller.updateProductName(text ?? '');
                  },
                  controller: controller.nameController,
                  icon: null,
                  mask: MaskTextInputFormatter(),
                  onSaved: (text) {},
                ),
                // Campo para valor do produto
                TextFildRounded(
                  readOnly: false,
                  heigth: Get.height * 0.055,
                  width: Get.width * 0.3,
                  description: 'Valor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  text: 'Valor',
                  validator: (text) {
                    return controller.validate(ValidationMode.value, text);
                  },
                  onChanged: (text) {
                    controller.updateProductValue(text!);
                  },
                  controller: controller.valorController,
                  icon: null,
                  mask: MaskTextInputFormatter(),
                  onSaved: (text) {},
                ),
              ],
            ),
          ),

          /// Seção: Descrição e Imagem do Produto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Campo para descrição do produto
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04),
                child: TextFildRounded(
                  readOnly: false,
                  heigth: Get.height * 0.047,
                  width: Get.width * 0.6,
                  description: 'Descrição',
                  keyboardType: TextInputType.text,
                  text: 'Descrição',
                  validator: (text) {
                    return controller.validate(ValidationMode.text, text);
                  },
                  onChanged: (text) {
                    controller.updateDescription(text ?? '');
                  },
                  controller: controller.descriptionController,
                  icon: null,
                  mask: MaskTextInputFormatter(),
                  onSaved: (text) {},
                ),
              ),
              // Botão para upload de imagem
              ButtonUpload(
                onPressed: () {
                  controller.pickImage(); // Abre seletor de imagens
                },
                width: Get.width * 0.3,
              ),
            ],
          ),

          /// Seção: WhatsApp e Checkbox
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Campo de número WhatsApp
                TextFildRounded(
                  readOnly: false,
                  heigth: Get.height * 0.055,
                  width: Get.width * 0.8,
                  description: '(DDD) NUMERO',
                  keyboardType: TextInputType.number,
                  text: 'Whatsapp',
                  icon: AppTheme.icons.whatsapp,
                  validator: (text) {
                    return controller.validate(ValidationMode.whats, text);
                  },
                  mask: MaskTextInputFormatter(
                    mask: '(##) #####-####',
                    filter: {"#": RegExp(r'[0-9]')},
                  ),
                  onChanged: (text) {
                    controller.updateWhatsapp(text ?? '');
                  },
                  onSaved: (text) {},
                  controller: controller.whatsController,
                ),
                // Checkbox para ativar/desativar WhatsApp
                Obx(() => CheckBoxEdit(
                      onChanged: (valor) {
                        controller.updateHaveWhats(valor ?? false);
                      },
                      isCheck: controller.product.value.haveWhats,
                      scale: Get.width * 0.004,
                    )),
              ],
            ),
          ),

          /// Seção: Telefone
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Campo de telefone (somente leitura)
                TextFildRounded(
                  readOnly: true,
                  heigth: Get.height * 0.055,
                  width: Get.width * 0.8,
                  text: 'Telefone',
                  icon: AppTheme.icons.phone,
                  controller: controller.phoneController,
                  description: '',
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    return null;
                  },
                  mask: MaskTextInputFormatter(),
                  onChanged: (text) {},
                  onSaved: (text) {},
                ),
                // Checkbox para ativar/desativar telefone
                Obx(() => CheckBoxEdit(
                      onChanged: (valor) {
                        controller.updateHavePhone(valor ?? false);
                      },
                      isCheck: controller.product.value.havePhone,
                      scale: Get.width * 0.004,
                    )),
              ],
            ),
          ),

          /// Seção: Email
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Campo de email (somente leitura)
                TextFildRounded(
                  readOnly: true,
                  heigth: Get.height * 0.055,
                  width: Get.width * 0.8,
                  text: 'E-mail',
                  icon: AppTheme.icons.letter,
                  controller: controller.emailController,
                  description: '',
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    return null;
                  },
                  mask: MaskTextInputFormatter(),
                  onChanged: (text) {},
                  onSaved: (text) {},
                ),
                // Checkbox para ativar/desativar email
                Obx(() => CheckBoxEdit(
                      onChanged: (valor) {
                        controller.updateHaveEmail(valor ?? false);
                      },
                      isCheck: controller.product.value.haveEmail,
                      scale: Get.width * 0.004,
                    )),
              ],
            ),
          ),

          /// Seção: Entrega e Botão Salvar
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Checkbox para ativar/desativar entrega
                Row(
                  children: [
                    Obx(() => CheckBoxEdit(
                          onChanged: (valor) {
                            controller.updateHaveDelivery(valor ?? false);
                          },
                          isCheck: controller.product.value.haveDelivery,
                          scale: Get.width * 0.003,
                        )),
                    Text(
                      'Faz entrega?',
                      style: TextStyle(fontSize: Get.height * 0.02),
                    ),
                  ],
                ),
                // Botão para salvar produto
                TextButtonRounded(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.addProduct(context); // Salva o produto
                    } else {
                      controller.erroMensagem(
                          context, "Existem campos que não foram preenchidos");
                    }
                  },
                  text: 'SALVAR',
                  style: ButtonStyleType.neutral,
                  height: Get.height * 0.05,
                  width: Get.width * 0.4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

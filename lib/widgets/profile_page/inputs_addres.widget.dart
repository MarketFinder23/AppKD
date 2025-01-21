import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputsAddress extends GetView<ProfileController> {
  const InputsAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário de entrada para informações de endereço
    return Form(
      key: controller.formAddresKey,
      child: Column(
        children: [
          // Campo de entrada para cidade
          TextFildUnderline(
            width: Get.width * 0.9,
            keyboardType: TextInputType.name,
            description: '',
            validator: (text) {
              return controller.validate(ValidationMode.text, text);
            },
            text: 'Cidade',
            height: Get.height * 0.1,
            icon: null,
            mask: MaskTextInputFormatter(),
            controller: controller.cityController,
            onChanged: (text) {},
            onSaved: (text) {},
            readOnly: false,
          ),
          SizedBox(
            width: Get.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Campo de entrada para bairro
                TextFildUnderline(
                  width: Get.width * 0.45,
                  keyboardType: TextInputType.name,
                  description: '',
                  height: Get.height * 0.1,
                  validator: (text) {
                    return controller.validate(ValidationMode.text, text);
                  },
                  text: 'Bairro',
                  icon: null,
                  mask: MaskTextInputFormatter(),
                  controller: controller.naibController,
                  onChanged: (text) {},
                  onSaved: (text) {},
                  readOnly: false,
                ),
                // Campo de entrada para CEP
                TextFildUnderline(
                  width: Get.width * 0.4,
                  keyboardType: TextInputType.number,
                  description: '',
                  height: Get.height * 0.1,
                  validator: (text) {
                    return controller.validate(ValidationMode.cep, text);
                  },
                  text: 'CEP',
                  icon: null,
                  mask: MaskTextInputFormatter(
                    mask: '#####-###', // Máscara para formato de CEP
                    filter: {
                      "#": RegExp(r'[0-9]')
                    }, // Apenas números permitidos
                  ),
                  controller: controller.cepController,
                  onChanged: (text) {},
                  onSaved: (text) {},
                  readOnly: false,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Campo de entrada para rua
                TextFildUnderline(
                  width: Get.width * 0.55,
                  height: Get.height * 0.1,
                  keyboardType: TextInputType.name,
                  description: '',
                  validator: (text) {
                    return controller.validate(ValidationMode.text, text);
                  },
                  text: 'Rua',
                  icon: null,
                  mask: MaskTextInputFormatter(),
                  controller: controller.streetController,
                  onChanged: (text) {},
                  onSaved: (text) {},
                  readOnly: false,
                ),
                // Campo de entrada para número
                TextFildUnderline(
                  width: Get.width * 0.3,
                  keyboardType: TextInputType.number,
                  description: '',
                  validator: (text) {
                    return controller.validate(ValidationMode.number, text);
                  },
                  text: 'Nº',
                  icon: null,
                  height: Get.height * 0.1,
                  mask: MaskTextInputFormatter(),
                  controller: controller.numController,
                  onChanged: (text) {},
                  onSaved: (text) {},
                  readOnly: false,
                ),
              ],
            ),
          ),
          // Campo de entrada para complemento
          TextFildUnderline(
            width: Get.width * 0.9,
            keyboardType: TextInputType.name,
            description: '',
            height: Get.height * 0.1,
            validator: (text) {
              return controller.validate(ValidationMode.text, text);
            },
            text: 'Complemento',
            icon: null,
            mask: MaskTextInputFormatter(),
            controller: controller.compController,
            onChanged: (text) {},
            onSaved: (text) {},
            readOnly: false,
          ),
        ],
      ),
    );
  }
}

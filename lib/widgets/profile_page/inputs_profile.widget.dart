import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/components/text_fild/textfild_underline.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import './../../deveatualizar.dart'; //Deve atualizar o botão de trocar senha

class InputsProfile extends GetView<ProfileController> {
  const InputsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Formulário de entrada para informações do perfil do usuário ou loja
    return SingleChildScrollView(
      child: Form(
        key: controller.formInfosKey,
        child: Column(
          children: [
            // Campo de entrada para o nome ou nome fantasia
            TextFildUnderline(
              width: Get.width * 0.9,
              height: Get.height * 0.1,
              keyboardType: TextInputType.name,
              description: '',
              validator: (text) {
                return controller.validate(ValidationMode.text, text);
              },
              text: controller.isUser ? 'Nome' : 'Nome Fantasia',
              icon: null,
              mask: MaskTextInputFormatter(),
              controller: controller.nameController,
              onChanged: (text) {
                controller.nameUser.value = text!;
              },
              onSaved: (text) {},
              readOnly: false,
            ),
            // Campo de entrada para razão social (somente para loja)
            if (!controller.isUser)
              TextFildUnderline(
                width: Get.width * 0.9,
                height: Get.height * 0.1,
                keyboardType: TextInputType.name,
                description: '',
                validator: (text) {
                  return controller.validate(ValidationMode.text, text);
                },
                text: 'Razão Social',
                icon: null,
                mask: MaskTextInputFormatter(),
                controller: controller.razaoController,
                onChanged: (text) {},
                onSaved: (text) {},
                readOnly: true,
              ),
            // Campo de entrada para e-mail
            TextFildUnderline(
              width: Get.width * 0.9,
              height: Get.height * 0.1,
              keyboardType: TextInputType.emailAddress,
              description: '',
              validator: (text) {
                return controller.validate(ValidationMode.email, text);
              },
              text: '',
              icon: AppTheme.icons.letter,
              mask: MaskTextInputFormatter(),
              controller: controller.emailController,
              onChanged: (text) {},
              onSaved: (text) {},
              readOnly: false,
            ),
            // Campo de entrada para telefone (somente para loja)
            if (!controller.isUser)
              TextFildUnderline(
                width: Get.width * 0.9,
                height: Get.height * 0.1,
                keyboardType: TextInputType.phone,
                description: '',
                validator: (text) {
                  return controller.validate(ValidationMode.phone, text);
                },
                text: '',
                icon: AppTheme.icons.phone,
                mask: MaskTextInputFormatter(),
                controller: controller.phoneController,
                onChanged: (text) {},
                onSaved: (text) {},
                readOnly: false,
              ),
            // Campo de entrada para WhatsApp
            TextFildUnderline(
              width: Get.width * 0.9,
              keyboardType: TextInputType.phone,
              description: '',
              height: Get.height * 0.1,
              validator: (text) {
                return controller.validate(ValidationMode.phone, text);
              },
              text: '',
              icon: AppTheme.icons.whatsapp,
              mask: MaskTextInputFormatter(),
              controller: controller.whatsController,
              onChanged: (text) {},
              onSaved: (text) {},
              readOnly: false,
            ),
            // Campo de entrada para CPF ou CNPJ
            TextFildUnderline(
              width: Get.width * 0.9,
              keyboardType: TextInputType.number,
              description: '',
              validator: (text) {
                return controller.validate(
                  controller.isUser ? ValidationMode.cpf : ValidationMode.cnpj,
                  text,
                );
              },
              text: controller.isUser ? 'CPF' : 'CNPJ',
              icon: null,
              mask: MaskTextInputFormatter(
                mask: controller.isUser
                    ? '###.###.###-##'
                    : '##.###.###/####-##', // Define a máscara para CPF ou CNPJ
                filter: {"#": RegExp(r'[0-9]')}, // Permite apenas números
              ),
              height: Get.height * 0.1,
              controller: controller.docController,
              onChanged: (text) {},
              onSaved: (text) {},
              readOnly: true,
            ),
            // Botão para trocar senha
            TextButtonRounded(
              onPressed: () {}, // Ainda por implementar
              text: 'TROCAR SENHA',
              style: ButtonStyleType.neutral,
              height: Get.height * 0.05,
              width: Get.width * 0.8,
            ),
          ],
        ),
      ),
    );
  }
}

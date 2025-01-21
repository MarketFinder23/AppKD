import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import 'package:market_finder/widgets/login_page/btns/btn_about_us_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/btns/btn_create_acount_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/btns/btn_forgot_password_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/btns/btn_login_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/filds/email_fild_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/filds/password_fild_login_page.widget.dart';

// Widget que representa o formulário de login com campos de entrada e botões de ação
class FormLoginPage extends GetView<LoginPageController> {
  const FormLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey, // Chave do formulário para validação
      autovalidateMode:
          AutovalidateMode.disabled, // Modo de validação automática desativado
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Espaçamento uniforme entre widgets
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Campos de entrada para email e senha
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height *
                        0.05), // Espaçamento vertical entre os campos
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EmailFildLoginPage(), // Campo de entrada para email
                    PasswordFildLoginPage(), // Campo de entrada para senha
                  ],
                ),
              ),
              // Botões de ação para login, esqueci minha senha e criar conta
              const Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Distribuição uniforme dos botões
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      LoginButtonLoginPage(), // Botão para login
                      ForgotPasswordButtonLoginPage(), // Botão para recuperação de senha
                    ],
                  ),
                  CreateAccountButtonLoginPage(), // Botão para criar conta
                ],
              ),
            ],
          ),
          const AboutUsButtonLoginPage(), // Botão "Sobre nós"
        ],
      ),
    );
  }
}

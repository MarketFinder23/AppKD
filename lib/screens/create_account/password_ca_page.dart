import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/btn_continue.widget.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/password_page/fild_password.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaPasswordPage extends GetView<CreateAccountController> {
  const CaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Define o fundo branco da tela
      body: SingleChildScrollView(
        // Permite rolagem caso o conteúdo ultrapasse a tela
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderCAPage(), // Cabeçalho com botão de voltar e logo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: TitleDescription(
                  // Exibe título e descrição explicando o objetivo da tela
                  title: 'Só por segurança vamos cadastrar uma SENHA!',
                  description:
                      'A senha será utilizada para acessar sua conta no sistema.',
                  fontSize: Get.height * 0.035, // Ajusta o tamanho do texto
                ),
              ),
              const FildsCaPassword(), // Campos de entrada para senha e confirmação
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                child: ContinueButtonCaPage(
                  // Botão para avançar no fluxo
                  formKeyCa:
                      controller.formKeyCaPassword, // Validação do formulário
                  nextPage: 'finish', // Próxima página a ser navegada
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

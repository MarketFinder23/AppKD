import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/btn_continue.widget.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/legal_page/fild_legal.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaLegalPage extends GetView<CreateAccountController> {
  const CaLegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Define o fundo branco da tela
      body: SingleChildScrollView(
        // Permite rolagem caso o conteúdo ultrapasse a altura da tela
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderCAPage(), // Exibe o cabeçalho com botão de voltar e logo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: TitleDescription(
                  // Título e descrição ajustados dinamicamente para o tipo de usuário
                  title: 'Quase acabando só mais alguns documentos!',
                  description: controller.isUser
                      ? 'Seu CPF poderá ser utilizado para realizar login na plataforma.'
                      : 'Seu CNPJ é importante para comprovar que você é realmente uma empresa, mantendo o comércio da MF justo apenas entre empresas registradas.',
                  fontSize: Get.height * 0.035, // Define o tamanho da fonte
                ),
              ), // Espaço antes dos campos de entrada
              const FildsCaLegal(), // Campos de entrada para CPF ou CNPJ
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                child: ContinueButtonCaPage(
                  // Botão para continuar ao próximo passo
                  formKeyCa: controller
                      .formKeyCaLegal, // Chave do formulário para validação
                  nextPage: 'password', // Define a próxima página no fluxo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

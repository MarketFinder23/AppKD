import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/select_user_page/store_options.widget.dart';
import 'package:market_finder/widgets/create_account_page/select_user_page/user_options.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaSelectUserPage extends GetView<CreateAccountController> {
  const CaSelectUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Define o fundo branco da tela
      body: SizedBox(
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
                // Título e descrição explicando o propósito da página
                title: 'Quais suas intenções com a KD?',
                description:
                    'Caso você possua uma loja, escolha a primeira opção, caso queira apenas encontrar produtos escolha a segunda opção.',
                fontSize: Get.height * 0.035, // Define o tamanho da fonte
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * 0.3),
              child: Column(
                children: [
                  // Botões de seleção para "Loja" e "Usuário"
                  Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.02),
                    child: const BtnStoreOption(), // Botão para a opção "Loja"
                  ),
                  const BtnUserOption(), // Botão para a opção "Usuário"
                ],
              ),
            ), // Espaçamento antes do rodapé
          ],
        ),
      ),
    );
  }
}

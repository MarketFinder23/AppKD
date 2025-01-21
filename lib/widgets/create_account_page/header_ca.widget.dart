import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/widgets/create_account_page/logo_ca_widget.dart';

// Componente de cabeçalho para a página de criação de conta
class HeaderCAPage extends StatelessWidget {
  const HeaderCAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // Define espaçamento horizontal e vertical proporcionais à tela
        horizontal: Get.width * 0.06,
        vertical: Get.height * 0.06,
      ),
      child: const Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Elementos nas extremidades
        children: [
          // Botão para voltar à tela anterior
          BackButton(),
          // Exibe o logotipo sem nome
          LogoCaPage(),
        ],
      ),
    );
  }
}

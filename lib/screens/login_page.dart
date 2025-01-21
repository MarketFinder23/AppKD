import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/login_page_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/login_page/form_login_page.widget.dart';
import 'package:market_finder/widgets/login_page/logo_login_page.widget.dart';

// Tela de Login utilizando o controlador de login (GetView)
class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Define a cor de fundo
      body: Stack(
        children: [
          SingleChildScrollView(
            // Permite rolagem caso o conteúdo seja maior que a tela
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.5,
                  child: const LogoLoginPage(), // Exibe a logo
                ),
                SizedBox(
                  height: Get.height * 0.5,
                  child:
                      const FormLoginPage(), // Formulário de login com campos e botões
                ),
              ],
            ),
          ),
          Obx(() {
            // Observa a variável tryLogin
            if (controller.tryLogin.value) {
              // Exibe o círculo de carregamento se tryLogin for true
              return Container(
                color: Colors.black.withOpacity(0.5), // Fundo semi-transparente
                child: const Center(
                  child: CircularProgressIndicator(), // Círculo de carregamento
                ),
              );
            } else {
              return const SizedBox
                  .shrink(); // Retorna um widget vazio se tryLogin for false
            }
          }),
        ],
      ),
    );
  }
}

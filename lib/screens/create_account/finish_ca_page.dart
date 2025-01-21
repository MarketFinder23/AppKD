import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/finish_page/btn_create_account.widget.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaFinishPage extends GetView<CreateAccountController> {
  const CaFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Fundo branco para a tela
      body: Stack(
        children: [
          // Conteúdo principal da página
          SingleChildScrollView(
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
                      // Título e descrição final baseados no tipo de usuário
                      title: controller.isUser
                          ? 'Parabéns! Agora você pode utilizar o KD? para encontrar produtos próximos a você.'
                          : 'Parabéns! Agora você pode utilizar o KD? para anunciar seus produtos e atrair mais clientes.',
                      description:
                          'Não esqueça de confirmar seu e-mail assim que possível, para garantir a segurança de sua conta e liberar a edição do seu perfil.',
                      fontSize: Get.height * 0.035, // Ajusta o tamanho do texto
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: Get.height * 0.25),
                    child: const BtnCreateAccount(),
                  ), // Botão para finalizar cadastro
                ],
              ),
            ),
          ),
          // Overlay de carregamento exibido quando `isConecting` é true
          Obx(() {
            if (controller.isConecting.value) {
              return Container(
                height: Get.height,
                width: Get.width,
                color: AppTheme.colors.black
                    .withOpacity(0.5), // Fundo semi-transparente
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme
                        .colors.primary, // Cor do indicador de progresso
                  ),
                ),
              );
            }
            return const SizedBox
                .shrink(); // Retorna um widget vazio caso `isConecting` seja false
          }),
        ],
      ),
    );
  }
}

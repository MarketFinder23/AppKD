import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/btn_continue.widget.dart';
import 'package:market_finder/widgets/create_account_page/name_page/filds_name.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaNamePage extends GetView<CreateAccountController> {
  const CaNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Monitora o estado de erro e exibe uma mensagem, se necessário
    Obx(() {
      if (controller.error.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.showErrorBox(context); // Exibe a caixa de erro
        });
      }
      return const SizedBox
          .shrink(); // Retorna um widget vazio enquanto monitora
    });

    // Tela para selecionar/preencher o nome do usuário ou da loja
    return Scaffold(
      backgroundColor: AppTheme.colors.white, // Define o fundo branco
      body: SingleChildScrollView(
        // Permite rolagem caso o conteúdo ultrapasse o tamanho da tela
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
                  title: controller.isUser
                      ? 'Como devemos te chamar?' // Usuário
                      : 'Como devemos chamar sua loja?', // Loja
                  description: controller.isUser
                      ? 'Seu nome é importante para facilitar a comunicação com a loja no momento em que você realizar pedidos.'
                      : 'A razão social é necessária para fins legais, e o nome fantasia será utilizado para apresentar a loja aos seus clientes.',
                  fontSize: Get.height * 0.035, // Define o tamanho da fonte
                ),
              ),
              const TextFildCaName(), // Campos de entrada para nome ou razão social
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                child: ContinueButtonCaPage(
                  // Botão para continuar ao próximo passo
                  formKeyCa: controller
                      .formKeyCaName, // Chave do formulário para validação
                  nextPage: 'contact', // Próxima página no fluxo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

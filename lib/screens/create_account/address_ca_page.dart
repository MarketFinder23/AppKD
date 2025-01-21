import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/address_page/fild_address.widget.dart';
import 'package:market_finder/widgets/create_account_page/address_page/icon_address.widget.dart';
import 'package:market_finder/widgets/create_account_page/btn_continue.widget.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaAddressPage extends GetView<CreateAccountController> {
  const CaAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Observa reativamente o estado de erro e exibe a mensagem de erro quando necessário
    return Obx(() {
      if (controller.error.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.showErrorBox(context); // Exibe a caixa de erro
        });
      }

      return Scaffold(
        backgroundColor: AppTheme.colors.white, // Define o fundo branco
        body: SingleChildScrollView(
          // Permite rolagem caso o conteúdo seja maior que a tela
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderCAPage(), // Componente do cabeçalho com botão de voltar e logo
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: TitleDescription(
                    // Título e descrição da página, ajustados conforme o tipo de usuário
                    title: 'Onde podemos encontrá-lo?',
                    description: controller.isUser
                        ? 'Seu endereço será utilizado para encontrar as lojas mais próximas de você.'
                        : 'Seu endereço será utilizado por seus clientes para encontrar sua loja com maior facilidade.',
                    fontSize: Get.height * 0.035, // Ajusta o tamanho do texto
                  ),
                ),
                const IconCaAddress(), // Ícone representando casa ou loja
                const FildsCaAddress(), // Campos de entrada para dados de endereço (CEP, rua, etc.)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: Get.height * 0.1,
                    top: Get.height * 0.05,
                  ),
                  child: ContinueButtonCaPage(
                    // Botão para continuar para a próxima página no fluxo
                    formKeyCa: controller.formKeyCaAddress,
                    nextPage: 'legal', // Nome da próxima página no fluxo
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

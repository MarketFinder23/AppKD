import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/create_account_page/btn_continue.widget.dart';
import 'package:market_finder/widgets/create_account_page/contact_page/fild_contact.widget.dart';
import 'package:market_finder/widgets/create_account_page/header_ca.widget.dart';
import 'package:market_finder/widgets/create_account_page/title_description.widget.dart';

class CaContactPage extends GetView<CreateAccountController> {
  const CaContactPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const HeaderCAPage(), // Cabeçalho com botão de voltar e logo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: TitleDescription(
                  // Título e descrição dinâmicos com base no tipo de usuário
                  title: controller.isUser
                      ? 'Como podemos contatá-lo?' // Usuário padrão
                      : 'Como seus clientes podem entrar em contato?', // Loja
                  description: controller.isUser
                      ? 'Seus contatos são importantes para mantê-lo atualizado sobre promoções e novos itens na sua região. Seu e-mail também será usado para acessar sua conta na MF.'
                      : 'Seus contatos são essenciais para que seus clientes enviem pedidos ou tirem dúvidas. Não se preocupe, você poderá alterá-los mais tarde.',
                  fontSize: Get.height * 0.035, // Define o tamanho da fonte
                ),
              ),
              const FildsCaContact(), // Campos de entrada: e-mail, telefone, etc.
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
                child: ContinueButtonCaPage(
                  // Botão para continuar para a próxima etapa
                  formKeyCa: controller.formKeyCaContact, // Valida o formulário
                  nextPage: 'address', // Define a próxima página no fluxo
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

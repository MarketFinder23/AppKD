import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:market_finder/widgets/profile_page/btns_profille.widget.dart';
import 'package:market_finder/widgets/profile_page/input_infos.widget.dart';
import 'package:market_finder/widgets/profile_page/name_user.widget.dart';
import 'package:market_finder/widgets/profile_page/switter_infos.widget.dart';

class ProfilePage extends StatelessWidget {
  final bool isUser;

  ProfilePage({super.key, required this.isUser}) {
    // Inicializa o controller com base no tipo de perfil
    Get.put(ProfileController(isUser: isUser));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      body: Obx(() {
        // Exibe o indicador de carregamento enquanto os dados estão sendo processados
        if (controller.isLoading.value) {
          return Container(
            width: Get.width,
            height: Get.height,
            color: AppTheme.colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.colors.primary,
              ),
            ),
          );
        } else {
          // Exibe os dados do perfil quando o carregamento é concluído
          return Padding(
            padding: EdgeInsets.only(top: Get.height * 0.06),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    color: AppTheme.colors.white,
                    child: const Column(
                      children: [
                        NameUser(), // Exibe o nome do usuário ou loja
                        SwitterInfos(), // Alterna entre informações do usuário e endereço
                        InpustArea(), // Área de edição controlada pelo SwitterInfos
                        BtnsProfille(), // Botões para salvar ou atualizar informações
                      ],
                    ),
                  ),
                  // Botão de logout
                  Positioned(
                    left: Get.width * 0.01,
                    top: Get.height * 0.01,
                    child: IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: AppTheme.colors.darkRed,
                        size: Get.height * 0.04,
                      ),
                      onPressed: () {
                        controller.logout(); // Ação de logout
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

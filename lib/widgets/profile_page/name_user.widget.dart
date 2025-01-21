import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

class NameUser extends GetView<ProfileController> {
  const NameUser({super.key});

  @override
  Widget build(BuildContext context) {
    // Exibe o nome do usuário ou nome fantasia da loja no topo da tela
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Exibição do nome
          Text(
            controller.nameUser.value,
            style: TextStyle(
              fontFamily: AppTheme.fonts.secudaryFont,
              fontSize: Get.height * 0.055,
            ),
          ),
          // Linha decorativa abaixo do nome
          Container(
            width: Get.width * 0.7,
            height: 1,
            color: AppTheme.colors.black,
          )
        ],
      );
    });
  }
}

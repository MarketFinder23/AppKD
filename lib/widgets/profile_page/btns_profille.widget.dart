import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/buttons/btn_text_rounded.dart';
import 'package:market_finder/controllers/profile_controller.dart';

class BtnsProfille extends GetView<ProfileController> {
  const BtnsProfille({super.key});

  @override
  Widget build(BuildContext context) {
    // Botão para atualizar as informações do perfil
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButtonRounded(
            onPressed: () {
              controller
                  .attInfos(); // Chama o método para atualizar as informações
            },
            text: 'ATUALIZAR INFORMAÇÕES',
            style: ButtonStyleType.neutral,
            height: Get.height * 0.05,
            width: Get.width * 0.9,
          ),
        ],
      ),
    );
  }
}

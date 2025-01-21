import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

class SwitterInfos extends GetView<ProfileController> {
  const SwitterInfos({super.key});

  @override
  Widget build(BuildContext context) {
    // Ícones para alternar entre os tipos de informações a serem editadas
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.03),
      child: SizedBox(
        height: Get.height * 0.12,
        child: Stack(
          children: [
            // Linha com os ícones de seleção
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.toggleInfosSelected(); // Alterna a seleção
                  },
                  child: SizedBox(
                    // Ícone de casa ou loja
                    width: Get.width * 0.5,
                    height: Get.height * 0.06,
                    child: Obx(() {
                      return Icon(
                        controller.isUser
                            ? AppTheme.icons.house // Ícone para usuário
                            : AppTheme.icons.store, // Ícone para loja
                        size: controller.infosSelected.value
                            ? Get.height * 0.055 // Tamanho quando selecionado
                            : Get.height * 0.05,
                        color: controller.infosSelected.value
                            ? AppTheme.colors.primary // Cor selecionada
                            : AppTheme.colors.black, // Cor não selecionada
                      );
                    }),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.toggleInfosSelected(); // Alterna a seleção
                  },
                  child: SizedBox(
                    // Ícone de GPS
                    width: Get.width * 0.5,
                    height: Get.height * 0.06,
                    child: Obx(() {
                      return Icon(
                        AppTheme.icons.gps,
                        size: controller.infosSelected.value
                            ? Get.height * 0.05
                            : Get.height * 0.055, // Alterna o tamanho do ícone
                        color: controller.infosSelected.value
                            ? AppTheme.colors.black
                            : AppTheme.colors.primary, // Alterna a cor do ícone
                      );
                    }),
                  ),
                ),
              ],
            ),
            // Linha animada para destacar o ícone selecionado
            Obx(() {
              return AnimatedAlign(
                alignment: controller.infosSelected.value
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  width: Get.width * 0.25,
                  height: 1,
                  color: AppTheme.colors.primary,
                  margin: EdgeInsets.only(
                    left: Get.width * 0.124,
                    right: Get.width * 0.124,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

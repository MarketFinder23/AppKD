import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/profile_controller.dart';
import 'package:market_finder/widgets/profile_page/inputs_addres.widget.dart';
import 'package:market_finder/widgets/profile_page/inputs_profile.widget.dart';

class InpustArea extends GetView<ProfileController> {
  const InpustArea({super.key});

  @override
  Widget build(BuildContext context) {
    // Controla os formulários principais de texto com animação
    return Obx(() {
      return SizedBox(
        width: Get.width * 0.9,
        height: Get.height * 0.55,
        child: Stack(
          children: [
            // Formulário de informações do usuário
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: controller.infosSelected.value
                  ? 0
                  : -MediaQuery.of(context).size.width,
              right: controller.infosSelected.value
                  ? 0
                  : MediaQuery.of(context).size.width,
              top: 0,
              bottom: 0,
              child: const InputsProfile(),
            ),
            // Formulário de informações de endereço
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: !controller.infosSelected.value
                  ? 0
                  : MediaQuery.of(context).size.width,
              right: !controller.infosSelected.value
                  ? 0
                  : -MediaQuery.of(context).size.width,
              top: 0,
              bottom: 0,
              child: const InputsAddress(),
            ),
          ],
        ),
      );
    });
  }
}

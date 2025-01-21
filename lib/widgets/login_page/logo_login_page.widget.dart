import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/components/logo.dart';
import 'package:market_finder/models/theme/theme.dart';

// Widget para exibir a logo na página de login
class LogoLoginPage extends StatelessWidget {
  const LogoLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Get.height * 0.1), // Espaçamento da parte superior
      child: Logo(
        svg: AppTheme.logos.logoName, // Nome do arquivo SVG da logo
        height: Get.height * 0.37, // Define a altura da logo
      ),
    );
  }
}

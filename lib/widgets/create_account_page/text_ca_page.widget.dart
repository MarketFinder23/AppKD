import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_finder/controllers/create_account_controller.dart';
import 'package:market_finder/models/theme/theme.dart';

// Widget que exibe um texto formatado com tamanho e fonte personalizados
class TextCaPage extends GetView<CreateAccountController> {
  final String text; // Texto que será exibido
  final double fontSize; // Tamanho da fonte para o texto

  const TextCaPage({
    super.key,
    required this.text, // Texto obrigatório
    required this.fontSize, // Tamanho da fonte obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text, // Exibe o texto fornecido
      textAlign: TextAlign.center, // Centraliza o texto horizontalmente
      style: TextStyle(
        fontSize: fontSize, // Aplica o tamanho da fonte fornecido
        fontFamily: AppTheme
            .fonts.primaryFont, // Usa a fonte personalizada definida no tema
      ),
    );
  }
}

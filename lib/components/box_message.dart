import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class BoxMessage {
  BoxMessage();

  // Função para mostrar uma mensagem com Snackbar
  void showMessage({
    required BuildContext context,
    required String message,
    Duration duration =
        const Duration(seconds: 1), // Duração padrão configurada
    Color? backgroundColor,
  }) {
    // Apenas exibe o novo SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppTheme.colors.white,
            fontFamily: AppTheme.fonts.primaryFont,
          ), // Texto padrão em branco
        ),
        backgroundColor: backgroundColor ??
            AppTheme.colors.primary, // Cor padrão configurável
        duration: duration,
      ),
    );
  }
}

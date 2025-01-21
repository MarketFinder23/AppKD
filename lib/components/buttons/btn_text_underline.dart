import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class TextButtonUnderline extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;

  const TextButtonUnderline({
    super.key,
    required this.onPressed,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove o padding padrão do TextButton
        minimumSize: Size.zero, // Remove restrições de tamanho mínimo
        tapTargetSize: MaterialTapTargetSize
            .shrinkWrap, // Reduz a área de toque ao conteúdo
        splashFactory:
            NoSplash.splashFactory, // Remove o efeito de splash ao clicar
      ),
      child: Text(
        text.toLowerCase(),
        style: TextStyle(
          color: AppTheme.colors.black,
          decoration: TextDecoration.underline,
          decorationColor: AppTheme.colors.primary,
          fontSize: fontSize,
          fontFamily: AppTheme.fonts.primaryFont,
        ),
      ),
    );
  }
}

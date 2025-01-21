import 'package:flutter/material.dart';
import 'package:market_finder/models/components/button_style.dart';
import 'package:market_finder/models/theme/theme.dart';

class TextButtonRounded extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonStyleType style;
  final double height;
  final double width;
  final String text;

  const TextButtonRounded({
    super.key,
    required this.onPressed,
    required this.text,
    required this.style,
    required this.height,
    required this.width,
  });

  // Método privado para definir estilos com base no tipo de botão
  ButtonStyleProperties _getStyle(ButtonStyleType style) {
    switch (style) {
      case ButtonStyleType.positive:
        return ButtonStyleProperties(
          backgroundColor: AppTheme.colors.white,
          overlayColor: AppTheme.colors.ligthGreen,
          textColor: AppTheme.colors.darkGreen,
        );
      case ButtonStyleType.negative:
        return ButtonStyleProperties(
          backgroundColor: AppTheme.colors.white,
          overlayColor: AppTheme.colors.ligthRed,
          textColor: AppTheme.colors.darkRed,
        );
      case ButtonStyleType.neutral:
        return ButtonStyleProperties(
          backgroundColor: AppTheme.colors.primary,
          overlayColor: AppTheme.colors.white,
          textColor: AppTheme.colors.white,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtem estilos com base no tipo fornecido
    final ButtonStyleProperties styleProperties = _getStyle(style);
    final double fontSize = height *
        0.4; // Define o tamanho da fonte proporcional à altura do botão
    final double borderRadius =
        height; // Define o raio de borda arredondada igual à altura

    return SizedBox(
      width: width, // Define a largura do botão
      height: height, // Define a altura do botão
      child: TextButton(
        onPressed:
            onPressed, // Callback que será chamado quando o botão for pressionado
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(styleProperties.backgroundColor),
          overlayColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return styleProperties.overlayColor;
              }
              return Colors.transparent;
            },
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        child: Center(
          // Centraliza o texto dentro do botão
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: styleProperties
                  .textColor, // Define a cor do texto com base no estilo do botão
              fontSize: fontSize,
              fontFamily: AppTheme.fonts.secudaryFont,
            ),
          ),
        ),
      ),
    );
  }
}

// Enum para definir os tipos de estilo do botão
enum ButtonStyleType {
  positive,
  negative,
  neutral,
}

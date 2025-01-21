import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class CircularButton extends StatelessWidget {
  // Callback para ser executado quando o botão é pressionado
  final VoidCallback onPressed;

  // Ícone a ser exibido dentro do botão
  final IconData? icon;

  // Tamanho do ícone (controla o tamanho total do botão)
  final double size;

  // Cor de fundo do botão, definida com base no ícone
  final Color backgroundColor;

  CircularButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.size,
  })   // Define a cor de fundo com base na condição: se o ícone for um "lixo" (bin), usa a cor `darkRed`, caso contrário, `primary`
  : backgroundColor = (icon == AppTheme.icons.bin)
            ? AppTheme.colors.darkRed
            : AppTheme.colors.primary,
        super(key: key);

  // Cor padrão para o ícone do botão
  final Color iconColor = AppTheme.colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 2,
      height: size * 2,
      // Define a cor de fundo e forma circular
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

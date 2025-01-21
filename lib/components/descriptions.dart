import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class Description extends StatefulWidget {
  final String description;
  final double width;
  final double fontSize;

  const Description({
    super.key,
    required this.width,
    required this.description,
    required this.fontSize,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Definindo o limite máximo de caracteres
    late int charLimit;

    widget.description.length < 60
        ? charLimit = widget.description.length
        : charLimit = 60;

    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Envolvendo o texto em AnimatedSize para efeito de animação
          AnimatedSize(
            duration: const Duration(milliseconds: 300), // Duração da animação
            curve: Curves.easeInOut, // Curva de animação
            child: Text(
              isExpanded
                  ? widget.description
                  : '${widget.description.substring(0, charLimit)}...',
              style: TextStyle(
                fontFamily: AppTheme.fonts.primaryFont,
                fontSize: widget.fontSize,
              ),
              maxLines: isExpanded ? null : 1, // Controla as linhas exibidas
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                isExpanded ? 'Ver menos' : 'Ver mais',
                style: TextStyle(
                  color: AppTheme.colors.primary,
                  fontFamily: AppTheme.fonts.primaryFont,
                  fontSize: widget.fontSize * 0.9, // Font menor para o botão
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0), // Espaçamento antes do divisor
          Divider(
            color: AppTheme.colors.primary,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class DropdownListText extends StatefulWidget {
  final List<String> list; // Lista de opções para o dropdown
  final String hint; // Texto de dica
  final Function(String) onChanged; // Callback ao selecionar um item
  final double height; // Altura do widget
  final double width; // Largura do widget

  const DropdownListText({
    super.key,
    required this.list,
    required this.hint,
    required this.onChanged,
    required this.height,
    required this.width,
  });

  @override
  State<DropdownListText> createState() => _DropdownListTextState();
}

class _DropdownListTextState extends State<DropdownListText> {
  // Variáveis para armazenar a cor de fundo e texto
  Color backgroudColor = AppTheme.colors.white;
  Color textColor = AppTheme.colors.black;

  // Valor atualmente selecionado
  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: backgroudColor, // Cor de fundo do dropdown
        borderRadius:
            BorderRadius.circular(widget.width * 0.1), // Bordas arredondadas
      ),
      child: Padding(
        padding: EdgeInsets.only(left: widget.width * 0.1), // Padding interno
        child: DropdownButton<String>(
          isExpanded: true, // Expande para ocupar a largura disponível
          hint: Text(widget.hint,
              style: TextStyle(color: textColor)), // Texto de dica
          dropdownColor: backgroudColor, // Cor de fundo das opções do dropdown
          icon: Icon(
            AppTheme.icons.triagle, // Ícone do dropdown
            color: textColor,
            size: widget.height * 0.6, // Tamanho do ícone com base na altura
          ),
          style: TextStyle(
            fontSize:
                widget.height * 0.3, // Tamanho da fonte com base na altura
            color: textColor, // Cor do texto
          ),
          underline: const SizedBox.shrink(), // Remove a linha inferior padrão
          value: value, // Valor atualmente selecionado
          onChanged: (newValue) {
            setState(() {
              value = newValue; // Atualiza o valor selecionado
            });
            widget.onChanged(newValue!); // Chama o callback com o novo valor
          },
          items: widget.list.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value, // Texto exibido
                overflow: TextOverflow
                    .ellipsis, // Limita o texto ao espaço disponível
              ),
            );
          }).toList(), // Converte a lista de opções para uma lista de DropdownMenuItem
        ),
      ),
    );
  }
}

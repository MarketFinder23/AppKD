import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class DropdownListNumber extends StatefulWidget {
  // Variáveis de configuração fornecidas pelo usuário
  final String un; // Unidade de medida (ex: unidades, kg, etc.)
  final int qntMax; // Quantidade máxima no dropdown
  final int valueDefault; // Valor padrão inicial selecionado
  final Function(int) onChangedNumber; // Callback executado ao mudar o valor
  final double height; // Altura do widget
  final double width; // Largura do widget

  const DropdownListNumber({
    super.key,
    required this.valueDefault,
    required this.onChangedNumber,
    required this.qntMax,
    required this.un,
    required this.height,
    required this.width,
  });

  @override
  State<DropdownListNumber> createState() => _DropdownListNumberState();
}

class _DropdownListNumberState extends State<DropdownListNumber> {
  late int value; // Valor atualmente selecionado no dropdown

  @override
  void initState() {
    super.initState();
    value = widget.valueDefault; // Inicializa com o valor padrão fornecido
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = widget.height *
        0.4; // Define o tamanho da fonte com base na altura do widget

    return Container(
      height: widget.height, // Define a altura do widget
      width: widget.width, // Define a largura do widget
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.width *
            0.1), // Define bordas arredondadas proporcionais à largura
      ),
      child: DropdownButton<int>(
        isExpanded:
            true, // Expande o dropdown para ocupar toda a largura disponível
        underline: const SizedBox
            .shrink(), // Remove a linha inferior padrão do dropdown
        icon: Icon(
          AppTheme.icons.triagle, // Ícone do dropdown (personalizado)
          color: AppTheme.colors.black,
          size: widget.height *
              0.8, // Define o tamanho do ícone com base na altura do widget
        ),
        dropdownColor: AppTheme.colors.white,
        style: TextStyle(
          fontSize: fontSize, // Define o tamanho da fonte com base na altura
          fontFamily: AppTheme.fonts.primaryFont, // Define a fonte a ser usada
          color: AppTheme.colors.black, // Define a cor do texto
        ),
        items: List.generate(
          widget
              .qntMax, // Gera uma lista de itens com base na quantidade máxima
          (index) => DropdownMenuItem(
            value: index + 1, // Define o valor do item
            child: Text('${index + 1} ${widget.un}'), // Texto do item
          ),
        ),
        value: value, // Valor atualmente selecionado
        onChanged: (newValue) async {
          if (newValue != null) {
            // Atualiza o estado com o novo valor selecionado
            setState(() {
              value = newValue;
            });
            // Chama a função de callback com o novo valor
            widget.onChangedNumber(newValue);
          }
        },
      ),
    );
  }
}

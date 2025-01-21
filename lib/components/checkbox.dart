import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

class CheckBoxEdit extends StatefulWidget {
  // Propriedades recebidas por parâmetro
  final bool isCheck; // Estado inicial do Checkbox
  final Function(bool?) onChanged; // Callback ao alterar o valor
  final double scale; // Escala do Checkbox (tamanho)

  const CheckBoxEdit({
    super.key,
    required this.isCheck,
    required this.onChanged,
    required this.scale,
  });

  @override
  State<CheckBoxEdit> createState() => _CheckBoxEditState();
}

class _CheckBoxEditState extends State<CheckBoxEdit> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      // Redimensiona o Checkbox usando a escala fornecida
      scale: widget.scale,
      child: Checkbox(
        value: widget.isCheck, // Define o estado atual do Checkbox
        onChanged: widget.onChanged, // Executa a função ao alterar o valor
        activeColor:
            AppTheme.colors.primary, // Cor quando o Checkbox está ativo
        checkColor: Colors.white, // Cor do ícone de check
      ),
    );
  }
}

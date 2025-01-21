import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFildRounded extends StatefulWidget {
  // Parâmetros do widget
  final MaskTextInputFormatter mask;
  final String? Function(String?) validator;
  final void Function(String?) onChanged;
  final void Function(String?) onSaved;
  final double width;
  final double heigth;
  final String text;
  final IconData? icon;
  final String description;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool readOnly;

  // Variável calculada para definir se é uma descrição longa
  final bool isDescription;

  const TextFildRounded({
    Key? key,
    required this.width,
    required this.description,
    required this.keyboardType,
    required this.text,
    required this.icon,
    required this.validator,
    required this.mask,
    required this.onChanged,
    required this.onSaved,
    required this.controller,
    required this.heigth,
    required this.readOnly,
  })  : isDescription = text == 'Descrição',
        super(key: key);

  @override
  State<TextFildRounded> createState() => _TextFildRoundedState();
}

class _TextFildRoundedState extends State<TextFildRounded> {
  // Variáveis fixas e de controle
  bool isFocused = false; // Indica se o campo está focado
  bool hasError = false; // Indica se há erro na validação

  @override
  void initState() {
    super.initState();

    // Listener para acompanhar mudanças no controlador e validar dinamicamente
    widget.controller.addListener(() {
      final isValid = widget.validator(widget.controller.text) == null;
      if (mounted) {
        setState(() {
          hasError = !isValid;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define a cor do campo com base no foco e na validação
    final Color color = hasError
        ? AppTheme.colors.darkRed
        : (isFocused ? AppTheme.colors.primary : AppTheme.colors.black);

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus; // Atualiza o estado do foco
        });
      },
      child: SizedBox(
        width: widget.width,
        height: widget.isDescription ? widget.heigth * 3 : widget.heigth,
        child: TextFormField(
          readOnly: widget.readOnly, // Define se o campo é somente leitura
          maxLength: widget.isDescription ? 1000 : 15, // Máximo de caracteres
          minLines: widget.isDescription ? 4 : null, // Linhas mínimas
          maxLines: widget.isDescription ? null : 1, // Linhas máximas
          autovalidateMode:
              AutovalidateMode.onUserInteraction, // Validação dinâmica
          inputFormatters: [widget.mask], // Máscara de entrada
          controller: widget.controller, // Controlador do campo
          validator: widget.validator, // Função de validação
          onChanged: widget.onChanged, // Callback ao alterar texto
          onSaved: widget.onSaved, // Callback ao salvar o campo
          keyboardType: widget.keyboardType, // Tipo de teclado
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.heigth * 0.15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.primary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(widget.heigth * 0.15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.darkRed,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.heigth * 0.15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.darkRed,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(widget.heigth * 0.15),
            ),
            errorStyle: const TextStyle(fontSize: 0), // Esconde o texto de erro
            prefixIcon: widget.icon == null
                ? null
                : Icon(
                    widget.icon,
                    color: color,
                  ),
            label: Text(
              widget.text,
              style: TextStyle(
                color: color,
              ),
            ),
            hintText: widget.description, // Texto de dica
            counterText: '', // Remove o contador padrão
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFildUnderline extends StatefulWidget {
  final MaskTextInputFormatter
      mask; // Máscara de entrada para formatar o texto digitado
  final String? Function(String?)
      validator; // Função de validação para o campo de texto
  final void Function(String?) onChanged; // Callback para quando o texto muda
  final void Function(String?)
      onSaved; // Callback para quando o valor do campo é salvo
  final double width; // Largura do campo
  final double height; // Altura do campo
  final String text; // Texto exibido no rótulo do campo
  final IconData? icon; // Ícone prefixado (se houver)
  final String description; // Texto de descrição ou dica
  final TextInputType keyboardType; // Tipo de entrada (ex: texto, numérico)
  final TextEditingController controller; // Controlador para o campo de texto
  final bool readOnly; // Indica se o campo é somente leitura

  const TextFildUnderline({
    super.key,
    required this.width,
    required this.keyboardType,
    required this.description,
    required this.validator,
    required this.text,
    required this.icon,
    required this.mask,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.readOnly,
    required this.height,
  });

  @override
  State<TextFildUnderline> createState() => _TextFildUnderlineState();
}

class _TextFildUnderlineState extends State<TextFildUnderline> {
  late bool
      obscureText; // Indica se o texto deve ser ocultado (ex: campo de senha)
  late Color iconColor; // Cor do ícone prefixado
  late IconData
      eyeIcon; // Ícone do olho para alternar a visibilidade do texto (campo de senha)

  @override
  void initState() {
    super.initState();
    // Inicializa variáveis com base no tipo do campo (senha)
    bool isPassword =
        widget.icon == AppTheme.icons.padlock || widget.text.contains('Senha');
    obscureText = isPassword;
    iconColor = AppTheme.colors.black; // Cor inicial do ícone
    eyeIcon = obscureText
        ? AppTheme.icons.eyeClose
        : AppTheme.icons.eyeOpen; // Ícone de olho fechado ou aberto
  }

  // Alterna a visibilidade do texto no campo (usado para campos de senha)
  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
      eyeIcon = obscureText ? AppTheme.icons.eyeClose : AppTheme.icons.eyeOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colors.white, // Define a cor de fundo do container
      width: widget.width, // Define a largura do container
      height: widget.height, // Define a altura do container
      child: Focus(
        // Controle de foco para mudar a cor do ícone quando em foco
        onFocusChange: (hasFocus) {
          setState(() {
            iconColor =
                hasFocus ? AppTheme.colors.primary : AppTheme.colors.black;
          });
        },
        child: TextFormField(
          readOnly: widget.readOnly, // Define se o campo é somente leitura
          autovalidateMode: AutovalidateMode
              .onUserInteraction, // Valida automaticamente ao interagir
          inputFormatters: [
            widget.mask
          ], // Aplica a máscara de formatação ao texto
          controller: widget.controller, // Controlador do campo de texto
          validator: widget.validator, // Função de validação do campo
          onChanged: widget.onChanged, // Callback para mudanças de texto
          onSaved: widget.onSaved, // Callback ao salvar o valor do campo
          obscureText: obscureText, // Determina se o texto deve ser ocultado
          keyboardType:
              widget.keyboardType, // Tipo de entrada (ex: texto, numérico)
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0, horizontal: 8.0), // Padding interno do campo
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.primary,
                width: 2.0,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.colors.darkRed,
                width: 1.0,
              ),
            ),
            errorStyle: TextStyle(
                color: AppTheme.colors.darkRed), // Estilo de mensagem de erro
            prefixIcon: widget.icon != null
                ? Icon(widget.icon,
                    color: iconColor) // Ícone prefixado com cor dinâmica
                : null,
            labelText: widget.text.isNotEmpty
                ? '  ${widget.text}'
                : null, // Rótulo do campo
            labelStyle: TextStyle(color: iconColor), // Estilo do rótulo
            suffixIcon: (widget.icon == AppTheme.icons.padlock ||
                    widget.text.contains('Senha'))
                ? IconButton(
                    onPressed:
                        _toggleObscureText, // Alterna a visibilidade do texto
                    icon: Icon(eyeIcon, color: iconColor),
                  )
                : null,
            hintText: widget.description, // Texto de dica
          ),
        ),
      ),
    );
  }
}

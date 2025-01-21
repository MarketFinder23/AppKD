import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:market_finder/models/theme/theme.dart';

// Função para construir um widget de imagem a partir de uma string codificada em base64
Widget buildImage(String img, double width, double height,
    {double borderRadius = 8.0}) {
  // Verifica se a string de imagem é vazia ou nula
  if (img.isEmpty) {
    // Retorna um widget de fallback caso a string esteja vazia
    return _buildFallbackImage(width, height, borderRadius);
  }

  try {
    // Tenta decodificar a string base64 para bytes
    Uint8List bytes = base64Decode(img);
    // Retorna um widget de imagem com bordas arredondadas
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(borderRadius), // Adiciona bordas arredondadas
      child: Image.memory(
        bytes, // Exibe a imagem a partir dos bytes decodificados
        width: width, // Define a largura da imagem
        height: height, // Define a altura da imagem
        fit: BoxFit
            .cover, // Ajusta a imagem para cobrir todo o espaço disponível
      ),
    );
  } catch (e) {
    // Retorna um widget de fallback em caso de falha na decodificação da imagem
    return _buildFallbackImage(width, height, borderRadius);
  }
}

// Método para construir uma imagem de fallback (mostrado em caso de erro ou imagem vazia)
Widget _buildFallbackImage(double width, double height, double borderRadius) {
  return ClipRRect(
    borderRadius:
        BorderRadius.circular(borderRadius), // Adiciona bordas arredondadas
    child: Container(
      width: width, // Define a largura do container de fallback
      height: height, // Define a altura do container de fallback
      color: AppTheme.colors.white, // Cor de fundo do container de fallback
      child: Center(
        child: Icon(
          // Ícone que indica que a imagem não pôde ser carregada
          AppTheme.icons.imgBlock,
          color: AppTheme.colors.darkRed, // Define a cor do ícone de fallback
          size: height * 0.4, // Define o tamanho do ícone proporcional à altura
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:rss_noticias/services/api_service.dart';
import 'dart:convert'; // Adicionado para utf8.decode

class PreferenciasScreen extends StatelessWidget {
  final int usuarioId;

  PreferenciasScreen({required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferências'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService().getPreferenciasUsuario(usuarioId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar preferências: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma preferência encontrada.'));
          }

          final dadosPreferencias = snapshot.data!;

          return ListView(
            children: [
              // Percorre as categorias e exibe as notícias
              ...dadosPreferencias['categoriasComNoticias']
                  .entries
                  .map((entry) {
                String categoria = entry.key;
                List noticias = entry.value;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        categoria,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ...noticias.map((noticia) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Título: ${noticia['titulo']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                // Exibir link da notícia
                                Text(
                                  'Link: ${noticia['link']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                // Exibir data de publicação
                                Text(
                                  'Data de Publicação: ${noticia['dataPublicacao']}',
                                ),
                                SizedBox(height: 5),
                                // Remover tags HTML da descrição
                                Text(
                                  'Descrição: ${_removeHtmlTags(noticia['descricao'])}',
                                ),
                                SizedBox(height: 10),
                               
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  // Função para remover tags HTML da descrição
  String _removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '').trim();
  }
}

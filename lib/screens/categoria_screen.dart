import 'package:flutter/material.dart';
import 'package:rss_noticias/services/api_service.dart';

class CategoriaScreen extends StatelessWidget {
  final int usuarioId; // ID do usuário passado como argumento
  final List<String> categorias = [
    'Mundo', 'Carros', 'Tecnologia e Games', 'Concursos e Emprego',
    'Política', 'Pop & Arte', 'Ciência e Saúde', 'Turismo e Viagem',
    'Economia', 'Planeta Bizarro', 'Educação', 'Música', 'Loterias', 'Natureza'
  ];

  CategoriaScreen({required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(); // Crie uma instância do seu serviço

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false, // Remove todas as rotas da pilha
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categorias[index]),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () async {
                final categoriaId = index + 1; // Supondo que o index corresponde ao ID da categoria
                final sucesso = await apiService.salvarPreferencia(usuarioId, categoriaId);

                if (sucesso) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${categorias[index]} adicionada às preferidas!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao salvar preferência!')),
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/preferencias', arguments: usuarioId);
        },
        label: Text('Preferências'),
        backgroundColor: Colors.green,
        icon: Icon(Icons.favorite),
      ),
    );
  }
}

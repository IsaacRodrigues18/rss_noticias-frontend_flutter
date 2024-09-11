import 'package:flutter/material.dart';
import 'package:rss_noticias/services/api_service.dart';
import 'login_screen.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ApiService apiService = ApiService();

  void _cadastrar() async {
    final nome = nomeController.text;
    final login = loginController.text;
    final senha = senhaController.text;
    final email = emailController.text;

    final dadosUsuario = {
      'nome': nome,
      'login': login,
      'senha': senha,
      'email': email,
      'dataNascimento': DateTime.now().toIso8601String(),  // Substitua por campo de data
      'status': true,
      'role': 'USER',
    };

    final result = await apiService.cadastrar(dadosUsuario);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
      Navigator.pop(context); // Volta para a tela de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CADASTRO'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cadastrar,
              child: Text('Cadastrar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Volta para a tela de login
              },
              child: Text('Voltar para Login'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rss_noticias/services/api_service.dart';
import 'cadastro_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final ApiService apiService = ApiService();

  void _login() async {
    final email = loginController.text;
    final senha = senhaController.text;

    final resultado = await apiService.login(email, senha);
    if (resultado != null && resultado['usuarioId'] != null) {
      final usuarioId = resultado['usuarioId'];
      Navigator.pushNamed(
        context,
        '/categorias',
        arguments: usuarioId, // Passa o ID do usuário para a tela de categorias
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar login!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              
              },
              child: Text('Realizar Cadastro') ,
              
            ),
          ],
        ),
      ),
    );
  }
}


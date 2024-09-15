import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Import necessário para DateFormat
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
  final TextEditingController dataNascimentoController = TextEditingController(); // Controlador para a data de nascimento
  final ApiService apiService = ApiService();

  // Formatar data no padrão dd/MM/yyyy ao sair do campo
  void _formatarData() {
    String input = dataNascimentoController.text;
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parseStrict(input);
      dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data inválida, por favor use o formato dd/MM/yyyy.')),
      );
    }
  }

  void _cadastrar() async {
    final nome = nomeController.text;
    final login = loginController.text;
    final senha = senhaController.text;
    final email = emailController.text;
    final dataNascimento = dataNascimentoController.text;

    if (dataNascimento.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira a data de nascimento.')),
      );
      return;
    }

    final dadosUsuario = {
      'nome': nome,
      'login': login,
      'senha': senha,
      'email': email,
      'dataNascimento': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parseStrict(dataNascimento)),  // Formato ISO
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
        child: SingleChildScrollView(
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
              TextField(
                controller: dataNascimentoController,
                decoration: InputDecoration(labelText: 'Data de Nascimento (dd/MM/yyyy)'),
                keyboardType: TextInputType.datetime,
                onEditingComplete: _formatarData, // Formata a data ao finalizar a edição
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
      ),
    );
  }
}

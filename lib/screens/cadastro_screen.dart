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
  
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário

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
    if (_formKey.currentState!.validate()) {
      final nome = nomeController.text;
      final login = loginController.text;
      final senha = senhaController.text;
      final email = emailController.text;
      final dataNascimento = dataNascimentoController.text;

      final dadosUsuario = {
        'nome': nome,
        'login': login,
        'senha': senha,
        'email': email,
        'dataNascimento': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parseStrict(dataNascimento)),  // Formato ISO
        'status': true,
        'role': 'USER',
      };

      final resultado = await apiService.cadastrar(dadosUsuario);
      if (resultado != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado)),
        );
        Navigator.pop(context); // Volta para a tela de login
      }
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
          child: Form(
            key: _formKey, // Atribuir a chave do formulário
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: loginController,
                  decoration: InputDecoration(labelText: 'Login'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu login.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dataNascimentoController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento (dd/MM/yyyy)'),
                  keyboardType: TextInputType.datetime,
                  onEditingComplete: _formatarData, // Formata a data ao finalizar a edição
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento.';
                    }
                    return null;
                  },
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
      ),
    );
  }
}


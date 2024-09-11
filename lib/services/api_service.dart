import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  final String baseUrl = "http://localhost:8080";

  Future<Map<String, dynamic>?> login(String login, String senha) async {
    try {
      print('Login: $login');
      print('Senha: $senha');

      final response = await http.post(
        Uri.parse('$baseUrl/usuario/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'login': login,
          'senha': senha,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Assumindo que o retorno é um JSON que inclui 'usuarioId'
        return jsonDecode(response.body); // Retorna o ID do usuário
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }

  Future<String?> cadastrar(Map<String, dynamic> dadosUsuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario/cadastra'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(dadosUsuario),
    );

    if (response.statusCode == 200) {
      return 'Usuário cadastrado com sucesso!';
    } else {
      return 'Erro ao cadastrar usuário.';
    }
  }

  Future<bool> salvarPreferencia(int usuarioId, int categoriaId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/preferencias/salvar'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'usuarioId': usuarioId,
        'categoriaId': categoriaId,
      }),
    );

    return response.statusCode == 200;
  }

  /*Future<Map<String, dynamic>?> getPreferenciasUsuario(int usuarioId) async {
    final url = Uri.parse('$baseUrl/preferencias/$usuarioId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Converte a resposta JSON em um Map
        return json.decode(response.body);
      } else {
        print('Erro ao buscar preferências: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro de conexão: $e');
      return null;
    }
  }*/

  Future<Map<String, dynamic>> getPreferenciasUsuario(int usuarioId) async {
  final url = Uri.parse('$baseUrl/preferencias/$usuarioId');
  try {
    final response = await http.get(url, headers: {"Accept-Charset": "utf-8"});

    if (response.statusCode == 200) {
      // Converte a resposta JSON em um Map
      return json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } else {
      print('Erro ao buscar preferências: ${response.statusCode}');
      // Retorna um Map vazio em caso de erro
      return {};
    }
  } catch (e) {
    print('Erro de conexão: $e');
    // Retorna um Map vazio em caso de erro
    return {};
  }
}



  Future<Map<String, dynamic>> buscarPreferencias(int usuarioId) async {
    final preferencias = await getPreferenciasUsuario(usuarioId);
    if (preferencias != null) {
      return preferencias;
    } else {
      return {}; // Retorna um mapa vazio se não houver preferências
    }
  }
}

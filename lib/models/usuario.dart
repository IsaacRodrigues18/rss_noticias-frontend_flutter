// lib/models/usuario.dart
class Usuario {
  final String nome;
  final String login;
  final String senha;
  final String email;
  final DateTime dataNascimento;
  final bool status;
  final String role;

  Usuario({
    required this.nome,
    required this.login,
    required this.senha,
    required this.email,
    required this.dataNascimento,
    required this.status,
    required this.role,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      login: json['login'],
      senha: json['senha'],
      email: json['email'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      status: json['status'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'login': login,
      'senha': senha,
      'email': email,
      'dataNascimento': dataNascimento.toIso8601String(),
      'status': status,
      'role': role,
    };
  }
}

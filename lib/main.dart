import 'package:flutter/material.dart';
import 'package:rss_noticias/screens/cadastro_screen.dart';
import 'package:rss_noticias/screens/categoria_screen.dart';
import 'package:rss_noticias/screens/preferencias_screen.dart';
import 'package:rss_noticias/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS-NOTÍCIAS',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/cadastro': (context) => CadastroScreen(),
        '/categorias': (context) {
          final usuarioId = ModalRoute.of(context)!.settings.arguments as int;
          return CategoriaScreen(usuarioId: usuarioId);
        },
        '/preferencias': (context) {
          final usuarioId = ModalRoute.of(context)!.settings.arguments as int;
          return PreferenciasScreen(usuarioId: usuarioId); // Agora passamos apenas o usuarioId
        },
      },
    );
  }
}

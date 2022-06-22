import 'package:chatapp/pages/pull.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/registro_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'registro': (_) => RegistroPage(),
  'loading': (_) => LoadingPage(),
  'pull': (_) => PullPage(),
};

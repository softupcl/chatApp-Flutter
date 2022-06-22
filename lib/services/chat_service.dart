import 'package:chatapp/models/models.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chatapp/global/environment.dart';

class ChatService extends ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> obtenerChat(String usuarioID) async {
    final token = await AuthService.obtenerToken();
    try {
      final url = Uri.parse('${Environments.apiUrl}/mensajes/$usuarioID');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      });

      final mensajesResponse = chatResponseFromJson(resp.body);

      return mensajesResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}

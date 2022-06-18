import 'dart:convert';

import 'package:chatapp/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/global/environment.dart';

class AuthService extends ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String?> obtenerToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> borrarToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse('${Environments.apiUrl}/login');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future registro(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final url = Uri.parse('${Environments.apiUrl}/login/nuevousuario');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final registroResponse = loginResponseFromJson(resp.body);
      usuario = registroResponse.usuario;
      await _guardarToken(registroResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> loginActivo() async {
    final token = await _storage.read(key: 'token');
    final url = Uri.parse('${Environments.apiUrl}/login/validartoken');

    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': token.toString()
    });

    if (resp.statusCode == 200) {
      final registroResponse = loginResponseFromJson(resp.body);
      usuario = registroResponse.usuario;
      await _guardarToken(registroResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}

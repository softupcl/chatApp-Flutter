// ignore_for_file: unused_field, avoid_print, prefer_final_fields

import 'package:chatapp/global/environment.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';

enum StatusServidor {
  online,
  offLine,
  conectando,
}

class SocketService with ChangeNotifier {
  StatusServidor _statusServidor = StatusServidor.conectando;
  late Socket _socket;

  StatusServidor get statusServidor => _statusServidor;
  Socket get socket => _socket;

  void conectar() async {
    final token = await AuthService.obtenerToken();
    //dart client
    _socket = io(
        Environments.socketUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .enableForceNew()
            .setExtraHeaders({
              'x-token': token,
            })
            .build());

    _socket.onConnect((_) {
      _statusServidor = StatusServidor.online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      _statusServidor = StatusServidor.offLine;
      notifyListeners();
    });
  }

  void desconectar() {
    _socket.disconnect();
  }

  void emit(String s, Map<String, String> map) {}
}

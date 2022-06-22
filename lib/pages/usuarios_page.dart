import 'package:chatapp/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';

import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_service.dart';

// ignore: use_key_in_widget_constructors
class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = UsuariosService();
  // RefreshController _refreshController =
  //   RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];
  @override
  void initState() {
    // TODO: implement initState
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.desconectar();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.borrarToken();
          },
          icon: Icon(
            Icons.exit_to_app_sharp,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.statusServidor == StatusServidor.online)
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[400],
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red[400],
                  ),
          )
        ],
      ),
      body: _listVewUsuarios(),
      floatingActionButton: FloatingActionButton(
        onPressed: _cargarUsuarios,
        child: Icon(Icons.refresh_outlined),
      ),
    );
  }

  ListView _listVewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioLisTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioLisTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _cargarUsuarios() async {
    usuarios = await usuariosService.obtenerUsuarios();
    setState(() {});
    //_refreshController.refreshCompleted();
    //_refreshController.loadComplete();
  }
}

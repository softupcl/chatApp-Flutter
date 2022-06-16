import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chatapp/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(online: true, email: 'test1@test.com', nombre: 'Felipe', uid: '1'),
    Usuario(online: true, email: 'test2@test.com', nombre: 'Pia', uid: '2'),
    Usuario(online: false, email: 'test3@test.com', nombre: 'Nacho', uid: '3'),
    Usuario(
        online: true, email: 'test14@test.com', nombre: 'Francesca', uid: '4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi nombre',
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.exit_to_app_sharp,
            color: Colors.black54,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            /*  child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ), */
            child: Icon(
              Icons.offline_bolt,
              color: Colors.red[400],
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onLoading: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[100]),
          waterDropColor: Colors.blue,
        ),
        child: _listVewUsuarios(),
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
    );
  }

  _cargarUsuarios() async {
    print('Pull refresh');
  }
}

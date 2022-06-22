import 'package:chatapp/global/environment.dart';
import 'package:chatapp/models/models.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> obtenerUsuarios() async {
    final token = await AuthService.obtenerToken();

    try {
      final url = Uri.parse('${Environments.apiUrl}/usuarios');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
      });

      final usuarioResponse = usuariosResponseFromJson(resp.body);

      return usuarioResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

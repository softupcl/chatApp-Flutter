import 'package:chatapp/helpers/mostrar_alerta.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLogo(
                  titulo: 'Registro',
                ),
                _Form(),
                CustomLabels(
                  ruta: 'login',
                  textoCuenta: '¿Ya tienes una cuenta?',
                  textoRuta: 'Ir al login',
                ),
                Text(
                  'Término y condiciones',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.person_outline,
            placeholder: 'Nombre',
            tipoTeclado: TextInputType.text,
            textEditingController: nombreController,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            tipoTeclado: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            esPassword: true,
            textEditingController: passController,
          ),
          BotonAzul(
            texto: "Crear cuenta",
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registroOk = await authService.registro(
                        nombreController.text.trim(),
                        emailController.text.trim(),
                        passController.text.trim());

                    if (registroOk == true) {
                      //Conectar al socket server
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Error en registro', registroOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}

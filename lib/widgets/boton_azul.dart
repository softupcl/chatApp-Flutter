import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final Function()? onPressed;

  const BotonAzul({
    super.key,
    required this.texto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.blue,
      primary: Colors.blue[500],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: raisedButtonStyle,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child:
              Text(texto, style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}

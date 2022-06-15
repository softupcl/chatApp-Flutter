import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final String titulo;

  const CustomLogo({
    super.key,
    required this.titulo,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage('assets/img/tag-logo.png')),
            SizedBox(height: 20),
            Text(titulo, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

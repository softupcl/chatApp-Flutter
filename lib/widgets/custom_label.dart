import 'package:flutter/material.dart';

class CustomLabels extends StatelessWidget {
  final String ruta;
  final String textoCuenta;
  final String textoRuta;

  const CustomLabels({
    super.key,
    required this.ruta,
    required this.textoCuenta,
    required this.textoRuta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            textoCuenta,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(
              textoRuta,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}

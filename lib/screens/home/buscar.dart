import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Buscar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChanged; // Cambiado a Function(String)
  const Buscar({
    Key? key, // Agregado Key
    required this.searchController,
    required this.onChanged,
  }) : super(key: key); // Llamando al constructor super con la key

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: kSearchbarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: searchController,
          onChanged: onChanged,
          style: TextStyle(color: kTitleTextColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Buscar',
            hintStyle: TextStyle(color: kTitleTextColor),
            prefixIcon: Icon(Icons.search, color: kTitleTextColor), // Icono sin ninguna interacción
          ),
        ),
      ),
    );
  }
}

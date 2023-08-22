import 'package:flutter/material.dart';

class Styles{
  static const List<BoxShadow> boxShadow1 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> boxShadow2 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> toastShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ];
}
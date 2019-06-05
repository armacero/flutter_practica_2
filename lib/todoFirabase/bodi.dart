import 'package:flutter/material.dart';

@immutable
class Body {
  final String title;
  final String body;

  const Body({
    @required this.title,
    @required this.body,
  });
}
import 'package:flutter/material.dart';

import '../Config/theme.dart';

class LayoutBackground extends StatelessWidget {
  final Widget content;
  const LayoutBackground({super.key,required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end:Alignment.topRight,
          stops: const [0.6, 1],
          colors: [accent,accent2],
        ),
      
      ),
      child: content));
  }
}
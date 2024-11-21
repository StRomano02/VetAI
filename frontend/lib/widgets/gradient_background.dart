import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFBBDEFB), // Blu chiaro nella parte superiore
            Color(0xFFE3F2FD), // Azzurro più tenue nella parte inferiore
          ],
        ),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIconButton extends StatelessWidget {
  final String lottieFile;
  final VoidCallback onPressed;

  const LottieIconButton({
    Key? key,
    required this.lottieFile,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Lottie.asset(
        lottieFile,
        fit: BoxFit.fill,
      ),
    );
  }
}

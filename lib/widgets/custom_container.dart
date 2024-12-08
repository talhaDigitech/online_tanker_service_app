import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final List<Color> gradientColors;
  final String centerText;
  final TextStyle? textStyle;

  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.gradientColors,
    required this.centerText,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    // Calculate responsive padding and font size
    final responsivePadding = screenSize.width * 0.04; // 4% of screen width
    final responsiveFontSize = screenSize.width * 0.04; // 4% of screen width

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsivePadding),
          child: Text(
            centerText,
            style: textStyle?.copyWith(
              fontSize: textStyle?.fontSize ?? responsiveFontSize,
            ) ?? TextStyle(
              fontSize: responsiveFontSize,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  RatingDisplay({
    @required this.value,
    this.size,
    this.starColor,
    Key key,
  });

  final double value;
  final Color starColor;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        5,
        (index) => index <= value - 1
            ? Icon(
                Icons.star,
                color: starColor ?? Colors.amberAccent,
                size: size ?? 16,
              )
            : Icon(
                Icons.star_border,
                color: starColor ?? Colors.amberAccent,
                size: size ?? 16,
              ),
      ),
    );
  }
}

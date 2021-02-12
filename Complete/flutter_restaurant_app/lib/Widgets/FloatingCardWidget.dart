import 'package:flutter/material.dart';

class FloatingCardWidget extends StatelessWidget {

  final double size;
  final color;
  final Widget widget;

  FloatingCardWidget({this.size, this.color, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10.0,
              spreadRadius: 0.5                          )
        ],
      ),
      height: size,
      child: widget
    );
  }
}

import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      //color: Colors.blue,
      child: Image.asset(
        'assets/pipeline.png',
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(MaterialApp(home: SwordApp()));
}

class SwordApp extends StatefulWidget {
  @override
  _SwordAppState createState() => _SwordAppState();
}

class _SwordAppState extends State<SwordApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotationX = 0.0;
  double _rotationY = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _rotationX += details.delta.dy * 0.01;
          _rotationY += details.delta.dx * 0.01;
        });
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sword App'),
          ),
          body: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspectiva
                    ..rotateX(_rotationX)
                    ..rotateY(_rotationY),
                  alignment: FractionalOffset.center,
                  child: Image.asset('assets/images/sword.png',
                      width: 200, height: 200),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

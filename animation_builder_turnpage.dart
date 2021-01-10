import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Customstack(),
    );
  }
}

class Customstack extends StatefulWidget {
  @override
  _CustomstackState createState() => _CustomstackState();
}

class _CustomstackState extends State<Customstack> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250)
    );
  }

  void toggle() {
    _animationController.isDismissed ? _animationController.forward() : _animationController.reverse();
  }
  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(color: Colors.blue);
    var myChild = Container(color: Colors.yellow);
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          double slide = .02 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);
          return Stack(
            children: [
              myDrawer,
              Transform(
                transform: Matrix4.identity()..translate(slide)..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: myChild
              ),
            ],
          );
        }

      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed && details.globalPosition.dx < 1;
    bool isDragCloseFromRight = _animationController.isCompleted && details.globalPosition.dx > 1;

    //_canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    // if(_canBeDragged){
    //   double delta = details.primaryDelta / slide;
    //   _animationController.value += delta;
    // }
  }

  void _onDragEnd(DragEndDetails details) {

  }
}



import 'package:flutter/material.dart';

class ButtonBottomNavigationBar extends StatefulWidget {
  bool isActive;
  IconData icon;
  String title;
  VoidCallback onPressed;

  ButtonBottomNavigationBar({this.isActive, this.icon, this.title, this.onPressed});

  @override
  _ButtonBottomNavigationBarState createState() =>
      _ButtonBottomNavigationBarState();
}

class _ButtonBottomNavigationBarState extends State<ButtonBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationValue;
  Animation<Color> _animationBackgroundColor;
  Animation<Color> _animationTextColor;

    _ButtonBottomNavigationBarState();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationValue = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animationBackgroundColor =
        ColorTween(begin: Colors.white, end: Color.fromRGBO(238, 244, 255, 1))
            .animate(_controller);
    _animationTextColor =
        ColorTween(begin: Colors.black, end: Color.fromRGBO(63, 109, 210, 1))
            .animate(_controller);

    if (widget.isActive){
      _controller.forward();
    }
  }


  @override
  void didUpdateWidget(ButtonBottomNavigationBar oldWidget) {
    if (oldWidget.isActive != widget.isActive){
      if (widget.isActive){
        _controller.forward();
      }
      else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: _animationBackgroundColor.value,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(widget.icon, color: _animationTextColor.value),
                  onPressed: widget.onPressed,
                ),
                Opacity(
                  opacity: _animationValue.value,
                  child: SizeTransition(
                    sizeFactor: _animationValue,
                    axisAlignment: 1,
                    axis: Axis.horizontal,
                    child: Text(
                      widget.title,
                      style: TextStyle(color: _animationTextColor.value),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:fluttercustommusic/model/genres.dart';

class SettingsScreen extends StatefulWidget {
  final double _height;

  SettingsScreen(this._height);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final double _heightCircularSlider = 150;
  final Color _mainColor = Color.fromRGBO(33, 36, 45, 1);
  List<Genres> genres;

  @override
  void initState() {
    genres = [
      Genres(
          title: 'Rock', valueLike: 62, valueCustom: 32, color: Colors.yellow),
      Genres(
          title: 'Metal', valueLike: 31, valueCustom: 60, color: Colors.blue),
      Genres(
          title: 'Classical',
          valueLike: 15,
          valueCustom: 10,
          color: Colors.red),
      Genres(title: 'Pop', valueLike: 27, valueCustom: 25, color: Colors.green)
    ];
  }

  Widget _buildTextTitle(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 35, horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget _buildCardLike(String title, int count, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
          color: _mainColor, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3)),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                count.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Color.fromRGBO(94, 99, 116, 1), fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCircularSlider(
      String title, int valueCustom, Color color, int index) {
    return Container(
        child: SingleCircularSlider(100, valueCustom,
            height: _heightCircularSlider,
            baseColor: _mainColor,
            handlerColor: Colors.white,
            showHandlerOutter: false, onSelectionChange: (_, value, __) {
      setState(() {
        genres[index].valueCustom = value;
      });
    },
            selectionColor: color,
            child: Center(
              child: Container(
                width: _heightCircularSlider,
                height: _heightCircularSlider,
                decoration:
                    BoxDecoration(color: _mainColor, shape: BoxShape.circle),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(valueCustom.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    Text(title,
                        style: const TextStyle(
                            color: Color.fromRGBO(94, 99, 116, 1),
                            fontSize: 16))
                  ],
                )),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._height,
      color: Color.fromRGBO(15, 15, 19, 1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextTitle('LIKE'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: genres
                      .map((item) => _buildCardLike(
                          item.title, item.valueLike, item.color))
                      .toList()),
            ),
            _buildTextTitle('CUSTOM'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: genres.asMap().entries.map((entry) {
                var item = entry.value;
                int index = entry.key;
                return _buildCircularSlider(
                    item.title, item.valueCustom, item.color, index);
              }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}

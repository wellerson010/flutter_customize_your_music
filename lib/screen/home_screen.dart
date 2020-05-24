import 'package:flutter/material.dart';
import 'package:fluttercustommusic/component/button_bottom_navigation_bar.dart';
import 'package:fluttercustommusic/model/music.dart';
import 'package:fluttercustommusic/screen/settings_screen.dart';
import 'package:fluttercustommusic/ui/item_music_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _panelChangeVisible = false;
  int _bottomNavigationIndex = 0;
  double _settingsScreenHeight = 500;

  AnimationController _controllerSlideUp;
  Animation<double> _slideUpAnimation;
  Animation<double> _rotateButtonAnimation;

  // TODO: Trocar esse valor fixo por 40% da tela
  // TODO: borda arrendoda inferior

  @override
  void initState() {
  //  _settingsScreenHeight = MediaQuery.of(context).size.width * 0.4;

    _controllerSlideUp = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideUpAnimation = Tween<double>(begin: 0, end: _settingsScreenHeight).animate(CurvedAnimation(
      parent: _controllerSlideUp,
      curve: Curves.easeIn
    ));
    _rotateButtonAnimation = Tween<double>(begin: 0, end: pi / 2).animate(CurvedAnimation(
        parent: _controllerSlideUp,
        curve: Interval(0.75, 1)
    ));

    super.initState();
  }

  void _changeBottomNavigationIndex(int value){
    setState(() {
      _bottomNavigationIndex = value;
    });
  }

  void _changeSlideUpBottom(){
    _panelChangeVisible = !_panelChangeVisible;

    if (_panelChangeVisible){
      _controllerSlideUp.forward();
    }
    else {
      _controllerSlideUp.reverse();
    }
  }

  Widget _bottomNavigation() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ButtonBottomNavigationBar(
                    isActive: _bottomNavigationIndex == 0,
                    title: 'Feed',
                    icon: Icons.outlined_flag,
                    onPressed: (){
                      _changeBottomNavigationIndex(0);
                    },
                  ),
                  ButtonBottomNavigationBar(
                    isActive: _bottomNavigationIndex == 1,
                    title: 'Feed',
                    icon: Icons.radio_button_unchecked,
                    onPressed: (){
                      _changeBottomNavigationIndex(1);
                    },
                  ),
                  ButtonBottomNavigationBar(
                    isActive: _bottomNavigationIndex == 2,
                    title: 'Profile',
                    icon: Icons.outlined_flag,
                    onPressed: (){
                      _changeBottomNavigationIndex(2);
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: AnimatedBuilder(
              animation: _controllerSlideUp,
              builder: (_, __){
                return Transform.rotate(
                  angle: _rotateButtonAnimation.value,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(31, 101, 255, 1),
                    ),
                    child: Icon(FontAwesomeIcons.ellipsisH, color: Colors.white, size: 22,),
                  ),
                );
              },
            ),
            onTap: _changeSlideUpBottom,
          )
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          'Feed',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        )),
        IconButton(
          icon: Icon(
            Icons.sort,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _listMusic() {
    List<Music> musics = _buildFakeMusics();

    return ListView.separated(
      itemCount: musics.length,
      itemBuilder: (context, index) {

        return ItemMusicTile(musics[index]);
      },
      separatorBuilder: (_, index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }

  Widget _mainContainer() {
    double multiplyFactor = (_panelChangeVisible) ? -(_settingsScreenHeight) : 0;

    return AnimatedBuilder(
      animation: _slideUpAnimation,
      builder: (_, __){
        return Transform.translate(
          offset: Offset(0, _slideUpAnimation.value * -1),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                      children: <Widget>[
                        _header(),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(child: _listMusic()),
                      ],
                    ),
                  )),
              _bottomNavigation()
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomHeader() {
    double height = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;

    return AnimatedBuilder(
      animation: _slideUpAnimation,
      builder: (_, __){
        return Transform.translate(
          offset: Offset(0, height - _slideUpAnimation.value - safeAreaHeight),
          child: SettingsScreen(_settingsScreenHeight),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white, Colors.grey[200], Colors.white])),
          child: SafeArea(
              child: Stack(
            children: <Widget>[_mainContainer(), _buildBottomHeader()],
          ))),
    );
  }

  List<Music> _buildFakeMusics() {
    return [
      Music(
          title: 'The Lazy Song',
          artist: 'Bruno Mars',
          pathAssetPicture: 'pictures/brunomars.jpg',
          time: '03:27'),
      Music(
          title: 'Big Girls Don\'t Cry',
          artist: 'Fergie',
          pathAssetPicture: 'pictures/fergie.jpg',
          time: '04:27'),
      Music(
          title: 'Cry Me A River',
          artist: 'Justin Timberlake',
          pathAssetPicture: 'pictures/timberlake.png',
          time: '03:33'),
      Music(
          title: '7/11',
          artist: 'Beyoncé',
          pathAssetPicture: 'pictures/beyonce.jpg',
          time: '04:10'),
      Music(
          title: 'The Lazy Song',
          artist: 'Bruno Mars',
          pathAssetPicture: 'pictures/beyonce.jpg',
          time: '03:27'),
      Music(
          title: 'The Lazy Song',
          artist: 'Bruno Mars',
          pathAssetPicture: 'pictures/beyonce.jpg',
          time: '03:27')
    ];
  }
}

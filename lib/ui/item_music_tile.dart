import 'package:flutter/material.dart';
import 'package:fluttercustommusic/model/music.dart';

class ItemMusicTile extends StatelessWidget {
  final Music _music;

  ItemMusicTile(this._music);

  @override
  Widget build(BuildContext context) {
    Color colorTime = Colors.grey[300];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, 15, 10, 15), //symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(_music.pathAssetPicture),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _music.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(_music.artist),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 5),
                            child:
                            Icon(Icons.access_time, color: colorTime)),
                        Text(
                          _music.time,
                          style: TextStyle(color: colorTime),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
      ),
    );
  }
}

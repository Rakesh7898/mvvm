import 'package:flutter/material.dart';
import 'package:flutter_mvvm_example/model/albums.dart';
import 'package:provider/provider.dart';

import '../view_model/album_view_model.dart';

class AlbumDetails extends StatelessWidget {
  const AlbumDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlbumViewModel albumModel = context.watch<AlbumViewModel>();
    var index = albumModel.selectIndex;
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${albumModel.albumList[index].title}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${albumModel.albumList[index].body}"),
              ),
              IconButton(
                onPressed: () =>
                    albumModel.addFavoutite(albumModel.albumList[index]),
                icon: (albumModel.albumList[index].isFavourite == false)
                    ? Icon(
                        Icons.favorite_outline_sharp,
                        color: Colors.grey,
                        size: 32,
                      )
                    : Icon(
                        Icons.favorite_sharp,
                        color: Colors.pink,
                        size: 32,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

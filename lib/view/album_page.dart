import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_example/view/FavouriteList.dart';
import 'package:flutter_mvvm_example/view_model/album_view_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumViewModel albumViewModel = context.watch<AlbumViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("Albums"), actions: [
        Badge(
          toAnimate: false,
          badgeContent: Text(
            albumViewModel.count.toString(),
            style: TextStyle(color: Colors.white),
          ),
          position: BadgePosition(top: 5, start: 30),
          elevation: 0,
          child: IconButton(
            icon: Icon(
              Icons.favorite_outline_sharp,
              size: 28,
            ),
            onPressed: () => Get.to(FavouriteList()),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ]),
      body: SafeArea(
        child: _buildMainBody(context, albumViewModel),
      ),
    );
  }

  Widget _buildMainBody(context, AlbumViewModel albumViewModel) {
    return FutureBuilder(
      initialData: albumViewModel.getAlbums(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: albumViewModel.albumList.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.white,
                    onTap: () async {
                      albumViewModel.selectAlbum(
                          index, albumViewModel.albumList[index]);
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        albumViewModel.albumList[index].title
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: (albumViewModel.selectIndex == index)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: (albumViewModel.selectIndex == index)
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${albumViewModel.albumList[index].body}",
                            style: TextStyle(
                                color: (albumViewModel.selectIndex == index)
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                        IconButton(
                          onPressed: () => albumViewModel
                              .addFavourite(albumViewModel.albumList[index]),
                          icon: (albumViewModel.albumList[index].isFavourite ==
                                  true)
                              ? Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.pink,
                                  size: 32,
                                )
                              : Icon(
                                  Icons.favorite_border_sharp,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.error.hashCode == 101) {
          return Text("Something Went Wrong");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

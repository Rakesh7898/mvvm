import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_example/view_model/album_view_model.dart';
import 'package:provider/provider.dart';

class FavouriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumViewModel albumViewModel = context.watch<AlbumViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("Favourite Albums")),
      body: SafeArea(
        child: _buildMainBody(context, albumViewModel),
      ),
    );
  }

  Widget _buildMainBody(context, AlbumViewModel albumViewModel) {
    return FutureBuilder(
      initialData: albumViewModel.favouriteAlbumsList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: albumViewModel.favouriteAlbumsList.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    tileColor: Colors.white,
                    onTap: () async {
                      albumViewModel.selectAlbum(
                          index, albumViewModel.favouriteAlbumsList[index]);
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        albumViewModel.favouriteAlbumsList[index].title
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
                            "${albumViewModel.favouriteAlbumsList[index].body}",
                            style: TextStyle(
                                color: (albumViewModel.selectIndex == index)
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                        IconButton(
                          onPressed: () => albumViewModel.addFavourite(
                              albumViewModel.favouriteAlbumsList[index]),
                          icon: (albumViewModel
                                      .favouriteAlbumsList[index].isFavourite ==
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

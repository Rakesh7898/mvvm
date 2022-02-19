import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:/view_model/album_view_model.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumViewModel albumViewModel = context.watch<AlbumViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("Albums")),
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
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${albumViewModel.albumList[index].body}",
                        style: TextStyle(
                            color: (albumViewModel.selectIndex == index)
                                ? Colors.blue
                                : Colors.grey),
                      ),
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

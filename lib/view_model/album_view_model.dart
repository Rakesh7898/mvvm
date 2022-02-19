import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_example/model/albums.dart';
import 'package:flutter_mvvm_example/service/api_service.dart';
import 'package:flutter_mvvm_example/utils/base.dart';
import 'package:get/get.dart';

import '../view/album_detail.dart';

class AlbumViewModel extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  List<Albums> albumList = [];
  Albums album = Albums();
  List dataList = [];
  var response;
  var selectIndex = 0;

  getAlbums() async {
    try {
      await apiServices.executeGet(Base.BaseUrl).then((value) => {
            response = value,
            dataList.addAll(response),
            for (var i = 0; i < dataList.length; i++)
              {
                album = Albums.fromJson(dataList[i]),
                albumList.add(album),
              },
            //  print(dataList[0]["albumId"]),
          });
    } catch (err) {
      print("Error ${err}");
    }
    notifyListeners();
  }

  selectAlbum(int index, Albums album) {
    selectIndex = index;
    print("Selected Album Here ${album.title}");
    Get.to(AlbumDetails());
    notifyListeners();
  }
}

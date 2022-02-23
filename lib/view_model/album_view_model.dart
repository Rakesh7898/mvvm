import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_example/model/albums.dart';
import 'package:flutter_mvvm_example/service/api_service.dart';
import 'package:flutter_mvvm_example/utils/base.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/album_detail.dart';

class AlbumViewModel extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  List<Albums> albumList = [];
  Albums album = Albums();
  List dataList = [];
  var response, favResponse;
  var selectIndex = 0;
  List<Albums> favouriteAlbumsList = [];
  final storage = GetStorage();
  int count = 0;

  selectAlbum(int index, Albums album) {
    selectIndex = index;
    print("Selected Album Here ${album.title}");
    Get.to(AlbumDetails());
    notifyListeners();
  }

  addFavourite(Albums albumData) {
    if (albumData.isFavourite == false) {
      albumData.isFavourite = true;
      favouriteAlbumsList.add(albumData);
      count = favouriteAlbumsList.length;
      storage.write(
          "favouriteAlbumsList", favouriteAlbumsList.toSet().toList());
    } else {
      albumData.isFavourite = false;
      favouriteAlbumsList.remove(albumData);
      storage.write(
          "favouriteAlbumsList", favouriteAlbumsList.toSet().toList());
      count = favouriteAlbumsList.length;
    }
    notifyListeners();
  }

  Future getAlbums() async {
    try {
      await apiServices.executeGet(Base.BaseUrl).then((value) => {
            response = value,
            for (var data in response)
              {
                album = Albums.fromJson(data),
                albumList.add(album),
                // favouriteAlbumsList.add();
              },
            //  print(dataList[0]["albumId"]),
          });
    } catch (err) {
      print("Error ${err}");
    }
    notifyListeners();
  }
}

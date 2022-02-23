// import 'package:flutter/material.dart';
//
// class Loader extends StatelessWidget {
//   const Loader({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: CircularProgressIndicator());
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Loader(BuildContext context) {
  return Container(
    color: Colors.black54.withOpacity(0.8),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Card(
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Loading",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Text(
                    "Please wait while we access data from server",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

import 'dart:convert';
import 'dart:io';
import 'package:trade_app/models/product_condition.dart';

class PostItem {
  final List<File>? images;
  final String? name;
  final String? description;
  final ProductCondition? condition;

  PostItem({this.images, this.name, this.description, this.condition});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> imageSet = [];
    if (images != null) {
      for (var image in images!) {
        imageSet.add({
          'photo': base64Encode(image.readAsBytesSync()),
        });
      }
    }

    return {
      'image_set': imageSet,
      'name': name,
      'description': description,
      'condition': condition.toString().split('.').last.toLowerCase(),
    };
  }
}
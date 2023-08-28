import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_app/constant/url.dart';

class ProfileModel {
  late String? topImage = '';

  ProfileModel({
    this.topImage,
  });
}

class ProfileProvider with ChangeNotifier {


}

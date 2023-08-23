import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Item {
  final List<File>? images;
  final String? name;
  final String? description;
  final ProductCondition? condition;

  Item({this.images, this.name, this.description, this.condition});

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

class ExhibitView extends StatefulWidget {
  const ExhibitView({super.key});

  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}

class _ExhibitViewState extends State<ExhibitView> {
  List<File> images = [];
  final _productNameController = TextEditingController();

  // final _conditionController = TextEditingController();
  final _productDetailsController = TextEditingController();
  ProductCondition? productCondition;

  Future<File?> _compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 2,
      format: CompressFormat.jpeg,
    );
    return result != null ? File(result.path) : null;
  }

  Future<void> _postItem(Item item) async {
    const url =
        "https://your-api-url.com/items"; // こちらのURLを実際のAPIのURLに置き換えてください
    final dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: jsonEncode(item.toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        debugPrint("Item successfully posted");
      } else {
        debugPrint("Error posting item: ${response.data}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ProductCondition>> colorEntries =
        <DropdownMenuEntry<ProductCondition>>[];
    for (final ProductCondition condition in ProductCondition.values) {
      colorEntries.add(
        DropdownMenuEntry<ProductCondition>(
          value: condition,
          label: condition.name!,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('出品ページ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: images.isEmpty
                    ? Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.photo,
                            size: 60, // アイコンのサイズを調整
                            color: Colors.grey[400], // アイコンの色を灰色に
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PhotoViewGallery.builder(
                                          itemCount: images.length,
                                          builder: (context, index) {
                                            return PhotoViewGalleryPageOptions(
                                              imageProvider:
                                                  FileImage(images[index]),
                                              minScale: PhotoViewComputedScale
                                                  .contained,
                                              maxScale: PhotoViewComputedScale
                                                  .covered,
                                            );
                                          },
                                          scrollPhysics:
                                              const BouncingScrollPhysics(),
                                          backgroundDecoration:
                                              const BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          pageController: PageController(
                                              initialPage: index),
                                        ),
                                      ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(
                                        images[index],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      color: Colors.grey,
                                      child: Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        images.removeAt(index);
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        color: Colors.red,
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),
              // 画像が4枚未満の場合のみ、画像追加ボタンを表示
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera),
                      label: const Text("撮影"),
                      onPressed: images.length < 4
                          ? () async {
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (pickedImage != null) {
                                final tempFile = File(pickedImage.path);
                                final targetPath =
                                    "${tempFile.path}_compressed.jpg";
                                final compressedImage =
                                    await _compressAndGetFile(
                                        tempFile, targetPath);
                                if (compressedImage != null) {
                                  setState(() {
                                    images.add(compressedImage);
                                  });
                                }
                              }
                            }
                          : null, // 画像が4枚以上の場合はボタンを無効化
                    ),
                  ),
                  const SizedBox(width: 10), // ボタン間のスペース
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera),
                      label: const Text("画像を選択"),
                      onPressed: images.length < 4
                          ? () async {
                              final pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                final tempFile = File(pickedImage.path);
                                final targetPath =
                                    "${tempFile.path}_compressed.jpg";
                                final compressedImage =
                                    await _compressAndGetFile(
                                        tempFile, targetPath);
                                if (compressedImage != null) {
                                  setState(() {
                                    images.add(compressedImage);
                                  });
                                }
                              }
                            }
                          : null, // 画像が4枚以上の場合はボタンを無効化
                      // final pickedImages = await ImagePicker().pickMultiImage();
                      // List<File> compressedImages = [];
                      // for (var pickedImage in pickedImages) {
                      //   final tempFile = File(pickedImage.path); // XFileをFileに変換
                      //   final targetPath = "${tempFile.path}_compressed.jpeg";
                      //   final compressedImage =
                      //       await _compressAndGetFile(tempFile, targetPath);
                      //   if (compressedImage != null) {
                      //     compressedImages.add(compressedImage);
                      //   }
                      // }
                      // setState(() {
                      //   images.addAll(compressedImages);
                      // });
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '商品名',
                ),
              ),
              const SizedBox(height: 16),
              DropdownMenu<ProductCondition>(
                initialSelection: ProductCondition.clean,
                // controller: _conditionController,
                label: const Text('Color'),
                dropdownMenuEntries: colorEntries,
                onSelected: (value) {
                  setState(() {
                    productCondition = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _productDetailsController,
                decoration: const InputDecoration(
                  labelText: '商品の詳細情報',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: '詳細情報を記入してください',
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final item = Item(
                        images: images,
                        name: _productNameController.text,
                        description: _productDetailsController.text,
                        condition: productCondition,
                      );
                      _postItem(item);
                    },
                    child: Text(
                      '出品',
                      style: MyTextStyles.mediumBold.copyWith(
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
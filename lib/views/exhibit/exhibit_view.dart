import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/models/post_item_model.dart';
import 'package:trade_app/models/product_condition.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:trade_app/models/writing_state.dart';
import 'package:trade_app/repository/item_repository_provider.dart';

class ExhibitView extends StatefulWidget {
  const ExhibitView({super.key});

  @override
  State<ExhibitView> createState() => _ExhibitViewState();
}

class _ExhibitViewState extends State<ExhibitView> {
  List<File> images = [];
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  ProductCondition? productCondition;
  WritingState? writingState;
  String? campus = "";

  Future<File?> _compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 2,
      format: CompressFormat.jpeg,
    );
    return result != null ? File(result.path) : null;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<DropdownMenuEntry<String>>> _loadCampusData() async {
    final campusList = await UserPreferences.getCampusList();
    final List<DropdownMenuEntry<String>> campusEntries =
        <DropdownMenuEntry<String>>[];
    for (final String campus in campusList) {
      campusEntries.add(
        DropdownMenuEntry<String>(
          value: campus,
          label: campus,
        ),
      );
    }
    return campusEntries;
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ProductCondition>> productConditionEntries =
        <DropdownMenuEntry<ProductCondition>>[];
    for (final ProductCondition condition in ProductCondition.values) {
      productConditionEntries.add(
        DropdownMenuEntry<ProductCondition>(
          value: condition,
          label: condition.jpName,
        ),
      );
    }
    final List<DropdownMenuEntry<WritingState>> writingStateEntries =
        <DropdownMenuEntry<WritingState>>[];
    for (final WritingState state in WritingState.values) {
      writingStateEntries.add(
        DropdownMenuEntry<WritingState>(
          value: state,
          label: state.jpName,
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: MyColors.ghostWhiteColor,
        //   title: const Text(
        //     Texts.exhibit,
        //   ),
        // ),
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
                  initialSelection: ProductCondition.brandNew,
                  label: const Text('商品の状態'),
                  dropdownMenuEntries: productConditionEntries,
                  onSelected: (value) {
                    setState(() {
                      productCondition = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownMenu<WritingState>(
                  initialSelection: WritingState.none,
                  label: const Text('書き込み'),
                  dropdownMenuEntries: writingStateEntries,
                  onSelected: (value) {
                    setState(() {
                      writingState = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<DropdownMenuEntry<String>>>(
                    future: _loadCampusData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownMenu<String>(
                          initialSelection: snapshot.data!.first.value,
                          label: const Text('キャンパス'),
                          dropdownMenuEntries: snapshot.data!,
                          onSelected: (value) {
                            setState(() {
                              campus = value;
                            });
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text("エラー");
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                const SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _productPriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '価格',
                    hintText: '1000'
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _productDescriptionController,
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
                        if (images.isNotEmpty&&(_productPriceController.text!='')) {
                          final item = PostItem(
                            images: images,
                            name: _productNameController.text,
                            condition: productCondition!.name,
                            writingState: writingState!.name,
                            receivableCampus: campus ?? "",
                            price: int.parse(_productPriceController.text),
                            description: _productDescriptionController.text,
                          );
                          ItemRepository.exhibitItem(item)
                              .then((isSuccess) {
                            if (isSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('出品が完了しました！'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('エラー   もう一度やり直して下さい。'),
                                ),
                              );
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('未記入の項目があります'),
                            ),
                          );
                        }
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
      ),
    );
  }
}

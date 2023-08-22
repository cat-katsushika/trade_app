import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

enum ProductCondition { clean, writtenOn, dirty }

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
  List<File>? _images = [];
  final _productNameController = TextEditingController();
  ProductCondition? _selectedCondition;
  final _productDetailsController = TextEditingController();

  Future<void> _postItem(Item item) async {
    const url = "https://your-api-url.com/items";  // こちらのURLを実際のAPIのURLに置き換えてください
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
        print("Item successfully posted");
      } else {
        print("Error posting item: ${response.data}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              ..._images!.map((image) => Image.file(
                image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              )),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text("画像を選択"),
                onPressed: () async {
                  final pickedImages = await ImagePicker().pickMultiImage();
                    setState(() {
                      _images!.addAll(pickedImages.map((pickedImage) => File(pickedImage.path)));
                    });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  labelText: '商品名',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<ProductCondition>(
                hint: const Text("商品の状態を選択"),
                value: _selectedCondition,
                items: ProductCondition.values.map((condition) {
                  return DropdownMenuItem<ProductCondition>(
                    value: condition,
                    child: Text(condition.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value;
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
              ElevatedButton(
                onPressed: () {
                  final item = Item(
                    images: _images,
                    name: _productNameController.text,
                    description: _productDetailsController.text,
                    condition: _selectedCondition,
                  );
                  _postItem(item);
                },
                child: const Text('出品'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

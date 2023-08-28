import 'package:flutter/material.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/views/item_detail/item_detail_view.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ItemDetailView(widget.item);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            children: [
              Image.network(widget.item.imageSet.first.photo),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "¥${widget.item.price}",
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.grey,
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

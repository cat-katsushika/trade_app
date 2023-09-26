import 'package:flutter/material.dart';
import 'package:trade_app/constant/image_path.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
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
    final listingStatus =
        ListingStatus.values.byName(widget.item.listingStatus);
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
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            children: [
              widget.item.images.isNotEmpty
                  ? Center(
                      child: Image.network(
                        widget.item.images.first.photoPath,
                        fit: BoxFit.contain,
                        errorBuilder: (c, o, s) {
                          print('Load failed : ${c.toString()}');
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Image.asset(ImagePath.errorImage),
                    ),
              if (listingStatus != ListingStatus.unpurchased)
                IgnorePointer(
                    child: Image.asset(
                  ImagePath.soldOutImage,
                  fit: BoxFit.contain,
                )),
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

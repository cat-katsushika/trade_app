import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/image_path.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.item, required this.navigate})
      : super(key: key);
  final Item item;

  //ItemCardからnavigateすると変更したstateが反映されないのでItemGridViewから遷移するため．
  final VoidCallback navigate;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final listingStatus =
        ListingStatus.values.byName(widget.item.listingStatus);
    return GestureDetector(
      onTap: () async {
        widget.navigate();
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
                      child: CachedNetworkImage(
                        imageUrl: widget.item.images.first.photoPath,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, dynamic error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.contain,
                      ),
                    )
                  : Center(
                      child: Image.asset(ImagePath.errorImage),
                    ),
              if (listingStatus == ListingStatus.purchased ||
                  listingStatus == ListingStatus.completed)
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

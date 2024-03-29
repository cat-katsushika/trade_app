import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/other_repository.dart';
import 'package:trade_app/views/top/item_grid_view_model.dart';

enum LikeStatus { undefined, unliked, liking, liked, failed }

class LikeButton extends ConsumerStatefulWidget {
  final String apiUrl;
  final Item item;

  const LikeButton({
    super.key,
    required this.apiUrl,
    required this.item,
  });

  @override
  ConsumerState createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  LikeStatus _status = LikeStatus.undefined;

  @override
  void initState() {
    print(widget.item.isLikedByCurrentUser);
    if (widget.item.isLikedByCurrentUser) {
      _status = LikeStatus.liked;
    }
    super.initState();
  }

  Future<bool> _toggleLike(WidgetRef ref) async {
    final itemsNotifier = ref.watch(itemsProvider.notifier);
    final likeItemsNotifier = ref.watch(likeItemsProvider.notifier);
    final purchasedItemsNotifier = ref.watch(purchasedItemsProvider.notifier);
    final listingItemsNotifier = ref.watch(listingItemsProvider.notifier);
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    setState(() => _status = LikeStatus.liking);
    try {
      final response = await dio.post(widget.apiUrl);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        if (response.data['message'] == Texts.likeToggleOnMessage) {
          setState(() => _status = LikeStatus.liked);
          itemsNotifier.toggleLike(widget.item.id, true);
          likeItemsNotifier.toggleLike(widget.item.id, true);
          purchasedItemsNotifier.toggleLike(widget.item.id, true);
          listingItemsNotifier.toggleLike(widget.item.id, true);
        } else if (response.data['message'] == Texts.likeToggleOffMessage) {
          itemsNotifier.toggleLike(widget.item.id, false);
          likeItemsNotifier.toggleLike(widget.item.id, false);
          purchasedItemsNotifier.toggleLike(widget.item.id, false);
          listingItemsNotifier.toggleLike(widget.item.id, false);
          setState(() => _status = LikeStatus.unliked);
        }
      } else {
        setState(() => _status = LikeStatus.failed);
        return false;
      }
      return true;
    } catch (error) {
      debugPrint(error.toString());
      setState(() => _status = LikeStatus.failed);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleLike(ref);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _status == LikeStatus.liking
              ? const CupertinoActivityIndicator()
              : Icon(
                  _status == LikeStatus.liked
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: MyColors.primary,
                  size: 28,
                ),
          const Text(
            'お気に入り',
            style: TextStyle(
              fontSize: 10,
              color: MyColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

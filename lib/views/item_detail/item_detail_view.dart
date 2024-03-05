import 'package:flutter/material.dart';
import 'package:trade_app/component/like_button.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/listing_status.dart';
import 'package:trade_app/models/user_data_model.dart';
import 'package:trade_app/repository/item_repository.dart';
import 'package:trade_app/views/item_detail/item_detail_common_view.dart';
import 'package:trade_app/views/item_detail/purchase_button_view.dart';
import 'package:trade_app/views/message_view/message_view.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';

class ItemDetailView extends StatefulWidget {
  const ItemDetailView(this.item, this.userData, {super.key});

  final Item item;
  final UserData userData;

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  patchTemplate(BuildContext context, String endpoint, String name) async {
    try {
      await ItemRepository.patchItemData(widget.item.id, endpoint);
      Future(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationRoot(snackMessage: '$nameが完了しました！'),
          ),
          (_) => false,
        );
      });
    } catch (e) {
      Future(() => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$nameに失敗しました。"),
            ),
          ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingStatus =
        ListingStatus.values.byName(widget.item.listingStatus);
    final deviseHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      ItemDetailCommonView(
                          item: widget.item, userData: widget.userData),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: MyColors.grey,
                          width: 1,
                        ),
                      ),
                      color: MyColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: PurchaseButtonView(
                              item: widget.item,
                              listingStatus: listingStatus,
                              onTapUnpurchased: () {
                                patchTemplate(context, 'purchase', '購入');
                              },
                              onTapRelist: () {
                                patchTemplate(context, 'relisting', '再出品');
                              },
                              onTapCancel: () {
                                patchTemplate(context, 'cancel', '出品取り消し');
                              },
                              onTapComplete: () {
                                patchTemplate(context, 'complete', '取引');
                              },
                            ),
                          ),
                          const Spacer(),
                          LikeButton(
                            apiUrl:
                                '${Url.apiUrl}items/${widget.item.id}/like-toggle/',
                            item: widget.item,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageView(
                item: widget.item,
                onTapComplete: null,
                isShowCompleteButton: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

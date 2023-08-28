enum ListingStatus { unpurchased, purchased, completed, canceled }

extension TypeExtensions on ListingStatus {
  String get jpName {
    switch (this) {
      case ListingStatus.unpurchased:
        return '未購入';
      case ListingStatus.purchased:
        return '購入済み';
      case ListingStatus.completed:
        return '取引完了';
      case ListingStatus.canceled:
        return 'キャンセル済み';
    }
  }
}

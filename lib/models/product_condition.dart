enum ProductCondition { brandNew, fine, used, damaged }

extension TypeExtensions on ProductCondition {
  String get jpName {
    switch (this) {
      case ProductCondition.brandNew:
        return '未使用';
      case ProductCondition.fine:
        return '目立った傷や汚れなし';
      case ProductCondition.used:
        return '使用感あり';
      case ProductCondition.damaged:
        return '破損あり';
    }
  }
// //予約語new回避のため.nameの代用として
//   String get name_ {
//     switch (this) {
//       case ProductCondition.brandNew:
//         return 'new';
//       case ProductCondition.fine:
//         return 'fine';
//       case ProductCondition.used:
//         return 'used';
//       case ProductCondition.damaged:
//         return 'damaged';
//     }
//   }
}

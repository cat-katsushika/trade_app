enum ProductCondition { clean, writtenOn, dirty }

extension TypeExtension on ProductCondition {
  static final names = {
    ProductCondition.clean: '美品',
    ProductCondition.writtenOn: '書き込み有',
    ProductCondition.dirty: '汚れ有'
  };

  String? get name => names[this];
}
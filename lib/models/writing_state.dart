enum WritingState {none, little, lot}

extension TypeExtensions on WritingState {
  String get jpName {
    switch (this) {
      case WritingState.none:
        return '全くない';
      case WritingState.little:
        return '少しある';
      case WritingState.lot:
        return 'かなりある';
    }
  }
}

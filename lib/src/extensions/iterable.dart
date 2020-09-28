extension IterableExtension on Iterable {

  T firstOr<T>(T value) => this.isEmpty ? value : this;

  T elementAtOrNull<T>(int index, [T optional]) {
    if (this.isEmpty) return optional;

    int elementIndex = 0;
    for (T element in this) {
      if (index == elementIndex) return element;
      elementIndex++;
    }

    return optional;
  }
}
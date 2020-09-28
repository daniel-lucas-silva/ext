import 'dart:collection' show MapBase;

extension LinkedHasMapExtension on MapBase {
  T serialize<T>(T Function(MapBase json) fromJson, [T or]) {
    if (this == null || this.isEmpty) return or;

    return fromJson(this);
  }
}

extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> filter([dynamic value]) {
    this.removeWhere((k, v) => v == value);
    return this;
  }

  T serialize<T>(T Function(Map json) fromJson, [T or]) {
    if (this == null || this.isEmpty) return or;

    return fromJson(this);
  }

  E find<E>(String path, [E or]) {
    final List<String> keys = path.split(".");

    if(this == null) return or;

    if (keys.length == 1)
      return this.containsKey(path) ? this[path] : or ?? null;

    dynamic result = this;

    keys.reduce((prev, curr) {
      if (result is Map &&
          result.containsKey(prev) &&
          result[prev] is Map &&
          result[prev].containsKey(curr)) {
        result = result[prev][curr];
      } else if (result is Map && result.containsKey(curr)) {
        result = result[curr];
      } else {
        result = or ?? null;
      }
      return curr;
    });

    if (or != null && or.runtimeType != result.runtimeType) return or;
    return result ?? or ?? null;
  }

  E findOr<E>(String path, String path2, [E or]) {
    return this.find(path) ?? this.find(path2) ?? or;
  }

  V containsOrFirst(K value, [V or]) {
    if (this.isNotEmpty && this.containsKey(value))
      return this[value];
    else if (this.isNotEmpty)
      return this.values.first;
    else
      return or;
  }

  V elementAt(K key, [V or]) {
    if (this.isNotEmpty && this.containsKey(key))
      return this[key];
    else
      return or;
  }
}
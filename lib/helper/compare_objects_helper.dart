class CompareObjectsHelper {
  static bool compareMaps(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    // Check if the maps have the same number of keys.
    if (map1.length != map2.length) {
      return false;
    }

    // Iterate over the keys of the first map and compare them to the keys of the second map.
    for (final key in map1.keys) {
      // If the key does not exist in the second map, then the maps are not equal.
      if (!map2.containsKey(key)) {
        return false;
      }

      // If the values for the key are not equal, then the maps are not equal.
      if (map1[key] != map2[key]) {
        if (map1[key] is Map && map2[key] is Map) {
          // If the values are both maps, then recursively compare the maps.
          if (!compareMaps(map1[key], map2[key])) {
            return false;
          }
        } else {
          // If the values are not both maps, then simply compare the values.
          if (map1[key] != map2[key]) {
            return false;
          }
        }
      }
    }

    // If all of the keys and values are equal, then the maps are equal.
    return true;
  }

  static bool listsEquals<T>(List<T>? list1, List<T>? list2) {
    if (list1 == null && list2 == null) return true;
    if (list1 == null || list2 == null) return false;

    if (list1.length != list2.length) {
      return false;
    }

    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }
}

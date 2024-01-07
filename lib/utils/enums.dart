class LanguageEnum {
  static const String english = 'en';
  static const String arabic = 'ar';
}

enum ActionType { add, remove }

enum MoveDirection { next, before }

enum TableMenuOption { add, show, edit, delete }

enum OrderDirection { up, down }

enum OrderByType { date, order, descendingOrder, ascendingOrder }

enum TableItemType { text, image, order, date, id, actions }

enum AddressPath { basketToCheckout, back }

enum AlgoliaSearchType { product, category }

class ThemeEnum {
  static const String light = 'light';
  static const String dark = 'dark';
}

class CategoryTypeEnum {
  static const String mostRecent = 'most_recent';
  static const String topRated = 'top_rated';
  static const String offers = 'offers';
  static const String mostPopular = 'most_popular';
  static const String featured = 'featured';
  static const String suggested = 'suggested';
  static const String general = 'general';
}

class InventoryType {
  static const String? def = null;
  static const String sizes = 'sized';
  static const String colors = 'colored';
  static const String colorsAndSizes = 'colored_and_sized';
}

class AlgoliaSearch {
  ///products
  static const String productsIndex = 'products';
  static const String productsApiKey = 'd8b2f0e8defcf6fd1158989e73279aec';

  ///categories
  static const String categoriesIndex = 'categories';
  static const String categoriesApiKey = '29eb77ded39580e8958a65862ae40a17';
}

class DiscoverType {
  static const String standard = 'standard';
  static const String productBanner = 'product_banner';
  static const String productsCarousel = 'products_carousel';
  static const String categoryBanner = 'category_banner';
  static const String categoriesCarousel = 'categories_carousel';
}

class AuthProviders {
  static const String google = 'google';
  static const String apple = 'apple';
  static const String phone = 'phone';
}

class BuildingType {
  static const String house = '1';
  static const String apartment = '2';
  static const String office = '3';
}

class OrderStatusEnum {
  static const String pending = '0'; //waiting for approve
  static const String preparing = '1'; //preparing
  static const String onTheWay = '2'; //on the way
  static const String arrived = '3'; //arrived
  static const String collecting = '4'; //collecting
  static const String completed = '5'; //completed
  static const String canceled = '6'; //canceled
  static const String rejected = '7'; //denied
}

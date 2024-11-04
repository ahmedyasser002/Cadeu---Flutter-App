class ProductDetailsModel {
  int? id;
  String? name;
  String? description;
  double? price;
  double? priceAfterDiscount;
  String? currency;
  String? storeName;
  double? avgRate;
  int? reviewsCount;
  List<String>? images;

  ProductDetailsModel(
      {required this.name,
      required this.id,
      required this.currency,
      required this.description,
      required this.images,
      required this.price,
      required this.priceAfterDiscount,
      required this.storeName,
      required this.avgRate,
      required this.reviewsCount});

  ProductDetailsModel.fromJson(Map<String, dynamic> product) {
    id = product['id'];
    name = product['name'];
    description = product['description'];
    price = product['price'];
    priceAfterDiscount = product['price_after_discount'];
    currency = product['currency']['name'];
    storeName = product['store']['name'];
    avgRate = product['avg_rate'];
    reviewsCount = product['reviews_count'];
    if (product['media'] != null) {
      images = [];
      for (var mediaItem in product['media']) {
        if (mediaItem['media_type'] == 'photo' && mediaItem['url'] != null) {
          images!.add(mediaItem['url']);
        }
      }
    }
  }
}

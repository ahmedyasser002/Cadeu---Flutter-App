// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsModel {
  int? id;
  String? name;
  double? priceAfter;
  double? price;
  String? currency;
  String? image;
  ProductsModel({
    required this.id,
    required this.name,
    required this.priceAfter,
    required this.price,
    required this.currency,
    required this.image,
  });
  ProductsModel.fromJson(Map product) {
    id = product['id'];
    name = product['name'];
    price = product['price'];
    priceAfter = product['price_after_discount'];
    currency = product['currency']['name'];
    image = product['image'];
  }
}

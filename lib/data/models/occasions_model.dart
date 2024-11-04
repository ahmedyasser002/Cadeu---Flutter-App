class OccasionsModel {
  int? id;
  String? description;
  String? name;
  String? banner;
  OccasionsModel(
      {this.banner,
      this.description,
      this.id,
      this.name});
  OccasionsModel.fromJson(Map occasion) {
    id = occasion['id'];
    description = occasion['description'];
    name = occasion['name'];
    banner = occasion['banner'];
  }
}

class ProductModel {
  int? id;
  String? name;
  String? imageLink;
  String? price;

  ProductModel({
    this.id,
    this.name,
    this.imageLink,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "price": price,
      };
}

class ProductModel {
  int? id;
  String? name;
  String? imageLink;
  String? description;
  String? price;
  bool? isPublished;

  ProductModel(
      {this.id,
      this.name,
      this.imageLink,
      this.description,
      this.price,
      this.isPublished});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        description: json["description"],
        price: json["price"],
        isPublished: json["isPublished"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "description": description,
        "price": price,
        "isPublished": isPublished,
      };
}

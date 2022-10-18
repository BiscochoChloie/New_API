class ProductModel {
  int id;
  String? name;
  String? imageLink;
  String? description;
  String? price;
  bool? isPublished;
  int? currentpage;
  int? lastpage;

  ProductModel(
      {required this.id,
      this.name,
      this.imageLink,
      this.description,
      this.price,
      this.isPublished,
      this.currentpage,
      this.lastpage});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageLink: json["image_link"],
        description: json["description"],
        price: json["price"],
        isPublished: json["isPublished"],
        currentpage: json["currentpage"],
        lastpage: json["lastpage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_link": imageLink,
        "description": description,
        "price": price,
        "isPublished": isPublished,
        "currentpage": currentpage,
        "lastpage": lastpage,
      };
}

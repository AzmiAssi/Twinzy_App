class Product {
  String? id;
  String? name;
  List? images;
  List? prices;
  String? description;
  List? sizes;
  String? rate;

  Product(
      {required this.name,
      required this.images,
      required this.prices,
      required this.description,
      required this.id,
      required this.sizes,
      required this.rate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      images: json['images'] as List,
      prices: json['prices'] as List,
      sizes: json['sizes'] as List,
      rate: json['rate'],
    );
  }
}

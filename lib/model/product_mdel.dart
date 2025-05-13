class ProductModel {
  String name;
  String category;
  List<dynamic>? images;
  String price;
  String quantity;
  String unitType;
  String? docId;
  String description;
  bool isOffer;
  String? offerPrice;

  ProductModel({
    required this.name,
    required this.price,
    required this.category,
    this.images,
    this.docId,
    required this.isOffer,
    this.offerPrice,
    required this.quantity,
    required this.unitType,
    required this.description,
  });
  factory ProductModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ProductModel(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      category: map['categoryId'] ?? '',
      images: map['images'] ?? [],
      quantity: map['quantity'] ?? '',
      unitType: map['unitType'] ?? '',
      description: map['discription'] ?? '',
      isOffer: map['offer'] ?? false,
      offerPrice: map['offerPrice'],
      docId: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'images': images,
      'quantity': quantity,
      'unitType': unitType,
      'description': description,
      'offer': isOffer,
      'offerPrice': offerPrice,
    };
  }
}

class CategoryModel {
  String id;
  String name;
  String image;
  CategoryModel(this.id, this.image, this.name);

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': image};
  }
}

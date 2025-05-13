import 'dart:typed_data';

class CategoryModel {
  String? docid;
  String name;
  Uint8List? imageBytes;
  CategoryModel({this.docid, this.imageBytes, required this.name});
}

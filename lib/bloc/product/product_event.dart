import 'package:equatable/equatable.dart';
import 'package:freshkart_admin/model/product_mdel.dart';

class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductsEvents extends ProductEvent {
  final String categoryName;
  LoadProductsEvents(this.categoryName);
}

class AddProductEvent extends ProductEvent {
  final ProductModel products;
  final List<String?> imageNames;
  AddProductEvent(this.products, this.imageNames);
  @override
  List<Object> get props => [products];
}

class UpdateProductEvent extends ProductEvent {
  final ProductModel updatedProducts;
  // final List<String>? imageNames;

  UpdateProductEvent(this.updatedProducts);
  @override
  List<Object?> get props => [updatedProducts];
}

class DeleteProductEvent extends ProductEvent {
  final String docId;
  DeleteProductEvent(this.docId);
}

class LoadOfferProductsEvent extends ProductEvent {
  LoadOfferProductsEvent();
}

class LoadOrderProductsEvent extends ProductEvent {
  final List<dynamic> orderProductsNames;
  LoadOrderProductsEvent(this.orderProductsNames);
  @override
  List<Object> get props => [orderProductsNames];
}

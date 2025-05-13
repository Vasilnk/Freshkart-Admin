import 'package:equatable/equatable.dart';
import 'package:freshkart_admin/model/product_mdel.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}

class OfferProductLoaded extends ProductState {
  final List<ProductModel> products;
  OfferProductLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class OrderProductLoaded extends ProductState {
  final List<ProductModel> orderedProducts;
  OrderProductLoaded(this.orderedProducts);
  @override
  List<Object?> get props => [orderedProducts];
}

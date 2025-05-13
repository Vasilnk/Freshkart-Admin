import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/product/product_event.dart';
import 'package:freshkart_admin/bloc/product/product_state.dart';
import 'package:freshkart_admin/model/product_mdel.dart';
import 'package:freshkart_admin/services/product_services.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirestoreProductServices productServices;
  ProductBloc(this.productServices) : super(ProductInitial()) {
    on<LoadProductsEvents>((event, emit) async {
      try {
        emit(ProductLoading());

        await for (var productList in productServices.getProducts(
          event.categoryName,
        )) {
          emit(ProductLoaded(productList));
        }
      } catch (error) {
        emit(ProductError(error.toString()));
      }
    });
    on<AddProductEvent>((event, emit) {
      try {
        emit(ProductLoading());

        productServices.addProduct(event.products, event.imageNames);
      } catch (error) {
        emit(ProductError(error.toString()));
      }
    });
    on<UpdateProductEvent>((event, emit) {
      try {
        emit(ProductLoading());
        productServices.updateProduct(event.updatedProducts);
      } catch (e) {}
    });
    on<DeleteProductEvent>((event, emit) {
      print('called delte');
      try {
        emit(ProductLoading());
        productServices.deleteProduct(event.docId);
      } catch (e) {}
    });
    on<LoadOfferProductsEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        await for (var snapshot in productServices.getOfferProducts()) {
          final products =
              snapshot.docs.map((doc) {
                return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
              }).toList();
          emit(OfferProductLoaded(products));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<LoadOrderProductsEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final orderProducts = await productServices.getOrderProducts(
          event.orderProductsNames,
        );
        emit(OrderProductLoaded(orderProducts));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}

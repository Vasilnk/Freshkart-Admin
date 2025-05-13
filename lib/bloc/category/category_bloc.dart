import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/services/category_services.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final FirestoreCategoryService firestoreService;

  CategoryBloc(this.firestoreService) : super(CategoryInitial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());

      try {
        await for (var snapshot in firestoreService.getCategories()) {
          emit(CategoryLoaded(snapshot.docs));
        }
      } catch (error) {
        emit(CategoryError(error.toString()));
      }
    });
    on<AddCategoryEvent>((event, emit) async {
      try {
        await firestoreService.addCategory(event.category, event.imageName);
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
    on<UpdateCategoryEvent>((event, emit) async {
      try {
        emit(CategoryLoading());

        await firestoreService.updateCategory(
          event.updatedCategory,
          event.imageName,
        );
      } catch (e) {}
    });
    on<DeleteCategoryEvent>((event, emit) {
      try {
        emit(CategoryLoading());
        firestoreService.deletCategory(event.categoryId);
      } catch (e) {}
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:freshkart_admin/model/category_model.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  final String imageName;

  AddCategoryEvent(this.category, this.imageName);

  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends CategoryEvent {
  final CategoryModel updatedCategory;
  final String imageName;

  UpdateCategoryEvent(this.updatedCategory, this.imageName);

  @override
  List<Object> get props => [updatedCategory];
}

class DeleteCategoryEvent extends CategoryEvent {
  final String categoryId;

  DeleteCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

import 'package:equatable/equatable.dart';

class CoverImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoverImagesInitial extends CoverImageState {}

class CoverImagesLoading extends CoverImageState {}

class CoverImagesLoaded extends CoverImageState {
  final List<String> coverImages;
  CoverImagesLoaded(this.coverImages);
  @override
  List<Object?> get props => [coverImages];
}

class CoverImagesError extends CoverImageState {}

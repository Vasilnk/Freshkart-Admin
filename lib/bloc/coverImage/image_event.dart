import 'package:equatable/equatable.dart';

class CoverImageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCoverImagesEvent extends CoverImageEvent {}

class UpdateCoverImagesEvent extends CoverImageEvent {
  final List<dynamic> coverImages;
  UpdateCoverImagesEvent(this.coverImages);
}

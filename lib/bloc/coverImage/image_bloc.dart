import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshkart_admin/bloc/coverImage/image_event.dart';
import 'package:freshkart_admin/bloc/coverImage/image_state.dart';
import 'package:freshkart_admin/services/cover_%20image_services.dart';

class CoverImageBloc extends Bloc<CoverImageEvent, CoverImageState> {
  CoverImageServices coverImageServce = CoverImageServices();
  CoverImageBloc(this.coverImageServce) : super(CoverImagesInitial()) {
    on<LoadCoverImagesEvent>((event, emit) async {
      try {
        emit(CoverImagesLoading());
        final images = await coverImageServce.getCoverImages();
        emit(CoverImagesLoaded(images));
      } catch (error) {
        emit(CoverImagesError());
      }
    });
    on<UpdateCoverImagesEvent>((event, emit) {
      try {
        emit(CoverImagesLoading());
        coverImageServce.updateCoverImages(event.coverImages);
      } catch (error) {
        emit(CoverImagesError());
      }
    });
  }
}

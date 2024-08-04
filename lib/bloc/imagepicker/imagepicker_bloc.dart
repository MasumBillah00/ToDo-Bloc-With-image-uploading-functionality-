import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilis/imagepicker_utilis.dart';
import 'imagepicker_event.dart';
import 'imagepicker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
    on<ClearImageEvent>(_clearImage); // Ensure this is registered
  }

  Future<void> _cameraCapture(CameraCapture event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.cameraCapture();
    emit(state.copyWith(file: file));
  }

  Future<void> _galleryPicker(GalleryPicker event, Emitter<ImagePickerState> emit) async {
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }

  void _clearImage(ClearImageEvent event, Emitter<ImagePickerState> emit) {
    emit(state.copyWith(file: null));
    print("Image cleared in state");
  }
}

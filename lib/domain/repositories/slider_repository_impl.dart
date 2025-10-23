import '../../data/models/slider_model.dart';

abstract class SliderRepositoryImpl {
  Future<List<SliderModel>> fetchSliders();
}

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/slider_model.dart';
import '../../data/repositories/slider_repository_impl.dart';

class SliderUsecases {
  final SliderRepositoryImpl sliderRepositoryImpl;

  SliderUsecases({required this.sliderRepositoryImpl});

  Future<Either<Failure, List<SliderModel>>> fetchSliders() {
    return sliderRepositoryImpl.fetchSliders();
  }
}

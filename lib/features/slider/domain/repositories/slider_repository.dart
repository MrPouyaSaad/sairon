import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/slider_model.dart';

abstract class SliderRepository {
  Future<Either<Failure, List<SliderModel>>> fetchSliders();
}

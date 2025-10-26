import 'package:dartz/dartz.dart';
import 'package:sairon/core/constants/api/api_constants.dart';
import 'package:sairon/core/errors/exception_mapper.dart';
import 'package:sairon/core/errors/failures.dart';
import 'package:sairon/features/slider/data/datasources/slider_remote_data_source.dart';
import 'package:sairon/features/slider/data/models/slider_model.dart';

import '../../domain/repositories/slider_repository.dart';

final dataSource = SliderRemoteDataSource(httpClient: ApiConstants.httpClient);
final sliderRepository = SliderRepositoryImpl(dataSource: dataSource);

class SliderRepositoryImpl implements SliderRepository {
  final SliderRemoteDataSource dataSource;

  SliderRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<SliderModel>>> fetchSliders() {
    return safeCall(() => dataSource.fetchSliders());
  }
}

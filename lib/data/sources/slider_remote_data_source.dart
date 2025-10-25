import 'package:dio/dio.dart';
import 'package:sairon/core/constants/api/app_routes.dart';
import 'package:sairon/core/errors/exception_mapper.dart';

import '../models/slider_model.dart';

class SliderRemoteDataSource {
  final Dio httpClient;
  SliderRemoteDataSource({required this.httpClient});

  Future<List<SliderModel>> fetchSliders() async {
    try {
      final res = await httpClient.get(AppRoutes.content.slider);
      final List<SliderModel> sliders = [];
      final data = res.data['data'];
      for (var sliderJson in data) {
        sliders.add(SliderModel.fromJson(sliderJson));
      }
      return sliders;
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (e) {
      throw Exception('مشکلی در پردازش داده رخ داده است.');
    }
  }
}

import '../../../core/utils/end_point_laravel.dart';
import '../../../core/utils/network/dio.dart';
import '../../../core/utils/network/error_message.dart';
import '../models/home_mode.dart';

abstract class BaseHomeRemoteDataSource {
  final DioHelper dioHelper;
  BaseHomeRemoteDataSource(this.dioHelper);
  Future<HomeModel> home();
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  HomeRemoteDataSource(super.dioHelper);
  @override
  Future<HomeModel> home() async {
    final result = await dioHelper.get(
      AppConstance.homeEndPoint,
    );
    if (result.success) {
      return HomeModel.fromJson(result.data);
    } else {
      throw ErrorMessageModel(result.msg, result.errType);
    }
  }
}

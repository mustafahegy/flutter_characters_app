import 'package:characters_actors/data/models/character.dart';
import 'package:dio/dio.dart';
import 'package:characters_actors/helpers/constants/strings.dart';

class CharactersApis {
  late Dio dio;

  CharactersApis() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000, // 60 seconds
      receiveTimeout: 30 * 1000, // 60 seconds
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacter() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}

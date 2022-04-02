import 'package:dio/dio.dart';
import 'package:my_flutter_block_mohammady/constants/strings.dart';
import 'package:my_flutter_block_mohammady/data/models/character.dart';

class CharacterWebServieces {
  Dio? dio;

  CharacterWebServieces() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20 * 100,
        receiveTimeout: 20 * 100,
        receiveDataWhenStatusError: true);
    dio = Dio(options);
  }
  Future<List<dynamic>> fetchAllCharacters()async{
    try{
      final Response response=await dio!.get("characters");
      return response.data;
    }catch(e){
      print(e.toString());
      return[];
    }
  }
  Future<List<dynamic>> fetchQuotes({required String chrName})async{
    try{
      final Response _response=await dio!.get("quote",queryParameters: {"author":chrName});
      return _response.data;
    }catch(e){
      print(e.toString());
      return[];
    }
  }
}

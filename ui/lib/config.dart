import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:harper/logger.dart';

class EnvLoader{
  static final EnvLoader _instance = EnvLoader._internal();
  factory EnvLoader(){
    return _instance;
  }
  EnvLoader._internal();
  Future<void> load() async {
    try {
      await dotenv.load();
      Logger().info('Load successful for env');
    }catch(e){
      Logger().error("Failed to load environment variables: $e");
    }
   
  }

  String? getProtocol(){
    return dotenv.env['PROTOCOL'];
  }
  String? getName(){
    return dotenv.env['NAME'];
  }

  String? getHost(){
    return dotenv.env['HOST'];
  }
  String? getPort(){
    return dotenv.env['PORT'];
  }
  String? getBaseApi(){
    return dotenv.env['BASE_API'];
  }
  String getApiUrl(){
    return '${getProtocol()}://${getHost()}:${getPort()}/${getBaseApi()}';
  }
}
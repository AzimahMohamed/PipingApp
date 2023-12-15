import 'package:tsk_sivil_app_new/networking.dart';

class Staff {
  Future<dynamic> getCiteWeather(String baseUrl, String staffId) async{
    var url = 'http://192.168.0.14/tsk-cp-erp-dev/public/api/get_operator-api?staff_id=$staffId';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
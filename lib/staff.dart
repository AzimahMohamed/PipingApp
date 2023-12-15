import 'package:tsk_sivil_app_new/networking.dart';

class Staff {
  Future<dynamic> getCiteWeather(String baseUrl, String staffId) async{
    var url = 'https://1.9.118.25:8822/new-tsk-cp-erp/public/api/get_operator-api?staff_id=$staffId';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
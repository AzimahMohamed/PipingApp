import 'package:tsk_sivil_app_new/networking.dart';

class DO {
  Future<dynamic> getDoId(int doID) async{
    var url = 'https://1.9.118.25:8822/new-tsk-cp-erp/public/api/civil/get-main-bom/bom-structure/$doID';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
import 'package:tsk_sivil_app_new/networking.dart';

class DO {
  Future<dynamic> getDoId(int doID) async{
    var url = 'http://192.168.0.14/tsk-cp-erp/public/api/civil/get-main-bom/bom-structure/$doID';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
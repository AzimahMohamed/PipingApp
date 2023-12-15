import 'package:tsk_sivil_app_new/networking.dart';

class PO {
  Future<dynamic> getPoId(int project_id) async{
    var url = 'http://192.168.0.14/new-tsk-cp-dev/public/api/get_job_order?project_id=$project_id';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
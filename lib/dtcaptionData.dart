import 'package:tsk_sivil_app_new/networking.dart';

class DTGallery {
  Future<dynamic> getDTGallery(String idDataTapping, String idItem) async{
    var url = 'https://1.9.118.25:8822/new-tsk-cp-erp/public/api/dti-gallery?data_tapping_id=$idDataTapping&data_tapping_item_id=$idItem';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    print(url);
    return weatherData;
  }
}
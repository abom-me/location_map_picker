
import 'package:geolocator/geolocator.dart';
import 'package:pin_google_map/src/helper/reqHelper.dart';


class HelperMethods {

  static Future findCordinateAdress(Position position, context,String langM,String mapAPI) async {
    var mlang = langM;
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&language=$mlang&key=$mapAPI';

    String? placeAdress = '';

    var response = await RequestHelper.getRequest(url);


      placeAdress = response['results'][0]['formatted_address'];


    return placeAdress;
  }




}
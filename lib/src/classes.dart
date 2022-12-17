import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinData {
  final LatLng latLong;
  final String location;



  PinData(this.latLong, this.location);
}

class Prediction{
  String? placeId;
  String? mainText;
  String? secondaryText;

  Prediction({
    this.placeId,
    this.mainText,
    this.secondaryText,
  });

  Prediction.fromJson(Map<String, dynamic> json){
    placeId = json['place_id'];
    mainText= json['structured_formatting']['main_text'];
    secondaryText = json['structured_formatting']['secondary_text'];
  }

}

class Address{
  late String? placeName;
  late double? latitude;
  late double? longitude;
  late String? placeId;
  Address({
    this.placeId,
    this.placeName,
    this.longitude,
    this.latitude
  });
}
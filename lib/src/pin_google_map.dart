import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes.dart';
import 'helper/helperClass.dart';
import 'helper/reqHelper.dart';
import 'helper/text.dart';
import 'helper/win.dart';
class pinGoogleMap extends StatefulWidget {
  pinGoogleMap({Key? key, required this.startLocation, required this.onPin,this.inputText,this.mapType, required this.mapApi,
    this.mapLanguage,
    this.inputIcon,
    this.inputColor,
    this.sendBtnIcon,
    required this.searchBoxHintText,

  }) : super(key: key);

  final LatLng startLocation;
  String? inputText;
  Widget? sendBtnIcon=const Icon(Icons.send);
  Color? inputColor;
  Widget? inputIcon;
  final String mapApi;
  final String searchBoxHintText;
  String? mapLanguage;
  MapType? mapType;
  final void Function(PinData pinData) onPin;
  @override
  State<pinGoogleMap> createState() => _pinGoogleMapState();
}

class _pinGoogleMapState extends State<pinGoogleMap> {
  late String mapLanguage=widget.mapLanguage??'en';
  late Widget sendBtnIcon=widget.sendBtnIcon??const Icon(Icons.send);
  late Color inputColor=widget.inputColor??Colors.black;
  late Widget inputIcon=widget.inputIcon??const Icon(Icons.location_on);
  late MapType mapType =widget.mapType??MapType.normal;
  List<Prediction> destinationPredictionList = [];
  TextEditingController search=TextEditingController();
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  late String locationName=widget.inputText ?? '...';
  bool pin=false;
  Future<PinData> pinData() async {

    return PinData(LatLng(cameraPosition!.target.latitude,cameraPosition!.target.longitude),locationName!);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset : false,


        body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                mapType: mapType,
                myLocationEnabled: true,
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: widget.startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                onCameraMove: (CameraPosition cameraPositiona) {

                  cameraPosition = cameraPositiona; //when map is dragging
                  setState(() {
                    pin=false;
                  });
                },
                onCameraIdle: () async { //when map drag stops
                  getPlaceName();
                },
              ),

              Center( //picker image on google map
                  child: pin ? SvgPicture.asset("assets/icons/pin.svg",width: 40,) : SvgPicture.asset("assets/icons/bpin.svg",width: 40,)),



              Positioned(  //widget to display location name
                  bottom:100,
                  child: Padding(

                    padding: const EdgeInsets.all(15),
                    child: Directionality(

                      textDirection: TextDirection.rtl,
                      child: Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const[
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10
                                )
                              ]
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 60,
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // mainAxisSize: MainAxisSize.max,

                            children: [
                              inputIcon!,
                              Expanded(child: AutoSizeFont(text: locationName, color: inputColor,size: 15,min: 7,maxLine: 3,)),
                              IconButton(
                                onPressed: (){
                                  pinData().then((value) => {
                                    widget.onPin(value),
                                  });
                                  Navigator.pop(context);
                                }, icon: sendBtnIcon,


                              )],
                          )
                      ),
                    ),
                  )
              ),
              Positioned(  //widget to display location name
                  top:30,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const[
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10
                            )
                          ]
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width - 40,
                      child:TextField(

                        decoration:  InputDecoration(
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: widget.searchBoxHintText
                        ),
                        controller: search,
                        onChanged: (value){
                          searchPlace(value);
                        },
                      ),
                    ),
                  )
              ),
              Positioned(
                // top: 150,
                child:
                (destinationPredictionList.length > 0 && search.text.length>1) ?
                Container(

                  padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.15, horizontal: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index){
                      return    InkWell(

                        onTap: (){
                          // print(destinationPredictionList[index].mainText.toString());
                          getPlaceDetails(destinationPredictionList[index].placeId as String);
                        },

                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),

                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 8,),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on, ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(destinationPredictionList[index].mainText as String, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16),),
                                        SizedBox(height: 2,),
                                        Text(destinationPredictionList[index].secondaryText as String, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, ),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8,),

                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => Divider(),
                    itemCount: destinationPredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
                    : Container(),)
            ]
        )
    );
  }
  getPlaceName()async{

    var placeNameTripTo=await HelperMethods.findCordinateAdress(
        Position(longitude: cameraPosition!.target.longitude, latitude: cameraPosition!.target.latitude, timestamp: null, accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0,),
        context,
        mapLanguage,
        widget.mapApi);

    setState(() { //get place name from lat and lang
      search.clear();
      locationName = placeNameTripTo;
      mapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition!));
      pin=true;
    });
  }


  void getPlaceDetails(String placeID) async {

    Alerts.loading(context,);

    String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=${widget.mapApi}';

    var response = await RequestHelper.getRequest(url);

    Navigator.pop(context);

    if(response == 'failed'){
      return;
    }

    if(response['status'] == 'OK'){

      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response ['result']['geometry']['location']['lat'];
      thisPlace.longitude = response ['result']['geometry']['location']['lng'];

      FocusManager.instance.primaryFocus?.unfocus();

      setState(() {
        cameraPosition=CameraPosition(zoom: 18,target: LatLng(thisPlace.latitude!.toDouble(),thisPlace.longitude!.toDouble()));
      });
      getPlaceName();
    }

  }
  searchPlace(String placeName) async {

    if(placeName.length > 1){

      String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${widget.mapApi}&sessiontoken=123254251&components=country:om';
      var response = await RequestHelper.getRequest(url);
// print(response['status']);
      if(response == 'failed'){
        return 'err';
      }

      if(response['status'] == 'OK'){
        var predictionJson = response['predictions'];
        var thisList = (predictionJson as List).map((e) => Prediction.fromJson(e)).toList();

        setState(() {
          destinationPredictionList = thisList;
        });

      }

    }

  }
}
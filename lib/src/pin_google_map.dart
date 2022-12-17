import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes.dart';
import 'helper/helperClass.dart';
import 'helper/reqHelper.dart';
import 'helper/text.dart';
import 'helper/win.dart';

class PinPlaceMap extends StatefulWidget {
  PinPlaceMap({
    Key? key,
     this.startLocation,
    required this.onPin,
    this.inputText,
    this.mapType,
    required this.apiKey,
    this.mapLanguage,
    this.inputIcon,
    this.textInputColor,
    this.sendBtnIcon,
     this.searchBoxHintText,
  }) : super(key: key);

  /// Here add the starting location, this location will appear directly when entering the widget
  ///<br>
  ///<br>
  /// You can leave it blank and it will use a default location
  ///<br>
  ///<br>
  ///<br>
  /// هنا قم بإضافة موقع البدء ، سوف يظهر هذا الموقع مباشرة عند الدخول للويدجت
  /// <br>
  /// <br>
  /// بإمكانك تركه فارغا وسوف يستعمل موقع افتراضي

  final LatLng? startLocation;
  /// Here, type the text that appears below before choosing a location, you can leave it blank
  ///<br>
  ///<br>
  ///<br>
  ///هنا قم بكتابة النص الذي يظهر بالاسفل قبل اختيار الموقع, بإمكانك تركه فارغا
  final String? inputText;

  /// Here is the widget that will appear in the submit button
  ///<br>
  ///<br>
  /// You can leave it blank and it will use the default send icon
  ///<br>
  ///<br>
  ///<br>
  ///هنا الويدجت الذي سوف يظهر في زر الارسال
  ///<br>
  ///<br>
  ///بإمكانك تركه فارغا وسوف يستعمل ايقونة الارسال الافتراضية

  final Widget? sendBtnIcon;
  ///هنا لون النص الخاص بمربع النص ، لونه اسود بشكل افتراضي
  ///<br>
  ///<br>
  ///<br>
  ///Here is the text color of the text box, it is black by default
  final Color? textInputColor;

  ///هنا الأيقونة التي تظهر بجانب مربع النص الخاص باسم الموقف، في الاسفل
  ///<br>
  ///<br>
  ///<br>
  /// Here is the icon that appears next to the text box for the position name, at the bottom
  final  Widget? inputIcon;
  /// This String is required and mandatory, here  type your API key from Google Cloud
  ///<br>
  ///<br>
  ///<br>
  ///هذا الString مطلوب و جباري، هنا  مفتاح الAPI الخاص بك من Google Cloud
  final String apiKey;
  /// Here is the text that will appear in the search box at the top
  /// <br>
  /// <br>
  /// default phrase (Search For A Place)
  ///<br>
  ///<br>
  ///<br>
  /// هنا النص الذي سوف يظهر في مربع البحث في الأعلى
  /// <br>
  /// <br>
  /// العبارة الافتراضية (Search For A Place)
  final  String? searchBoxHintText;
  /// Here is the language of the map and the name of the places, just type the language code
  /// <br>
  /// <br>
  /// For example: for Arabic (ar) for English (en)
  /// <br>
  /// <br>
  /// You can leave it blank and it will be in English by default
  /// <br>
  /// <br>
  /// <br>
   ///هنا لغة الخريطة و اسم الاماكن ، اكتب رمز اللغة فقط
  /// <br>
  /// <br>
  /// مثلا : للعربية (ar) للانجليزية (en)
  /// <br>
  /// <br>
  /// بامكانك تركها فارغة وسوف تكون بالانجليزية بشكل افتراضي
  final String? mapLanguage;
  ///Here is type of the map, if it is normal, satellite, etc
  /// <br>
  /// <br>
  /// <br>
  ///هنا نوع الخريطة اذا كانت افتراضية او قمر صناعي وغيره
  final MapType? mapType;
  /// Here comes the data after selecting the location, including the name of the place and its LatLng
  /// <br>
  /// <br>
  /// <br>
  /// هنا تأتي البيانات بعد اختيار الموقع بداخله اسم المكان و الLatLng الخاص به
  final void Function(PinData pinData) onPin;

  @override
  State<PinPlaceMap> createState() => _PinPlaceMapState();
}

class _PinPlaceMapState extends State<PinPlaceMap> {
  late LatLng startLocation = widget.startLocation ?? const LatLng(23.5838126,58.38648);
  late String mapLanguage = widget.mapLanguage ?? 'en';
  late String searchBoxHintText = widget.searchBoxHintText ?? 'Search For A Place';
  late Widget sendBtnIcon = widget.sendBtnIcon ?? const Icon(Icons.send);
  late Color inputColor = widget.textInputColor ?? Colors.black;
  late Widget inputIcon = widget.inputIcon ?? const Icon(Icons.location_on);
  late MapType mapType = widget.mapType ?? MapType.normal;
  List<Prediction> destinationPredictionList = [];
  TextEditingController search = TextEditingController();
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  late String locationName = widget.inputText ?? '...';
  bool pin = false;

  Future<PinData> pinData() async {
    return PinData(
        LatLng(
            cameraPosition!.target.latitude, cameraPosition!.target.longitude),
        locationName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            mapType: mapType,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
              setState(() {
                pin = false;
              });
            },
            onCameraIdle: () async {
              //when map drag stops
              getPlaceName();
            },
          ),
          Center(
              //picker image on google map
              child: pin
                  ? SvgPicture.asset(
                      "assets/icons/pin.svg",
                      width: 40,
                    )
                  : SvgPicture.asset(
                      "assets/icons/bpin.svg",
                      width: 40,
                    )),
          Positioned(
              //widget to display location name
              bottom: 100,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ]),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 40,
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // mainAxisSize: MainAxisSize.max,

                        children: [
                          inputIcon,
                          Expanded(
                              child: AutoSizeFont(
                            text: locationName,
                            color: inputColor,
                            size: 15,
                            min: 7,
                            maxLine: 3,
                          )),
                          IconButton(
                            onPressed: () {
                              pinData().then((value) => {
                                    widget.onPin(value),
                                  });
                              Navigator.pop(context);
                            },
                            icon: sendBtnIcon,
                          )
                        ],
                      )),
                ),
              )),
          Positioned(
              //widget to display location name
              top: 30,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ]),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextField(
                    decoration: InputDecoration(
                        icon: const Icon(Icons.search),
                        border: InputBorder.none,
                        hintText:searchBoxHintText),
                    controller: search,
                    onChanged: (value) {
                      searchPlace(value);
                    },
                  ),
                ),
              )),
          Positioned(
            // top: 150,
            child:
                (destinationPredictionList.isNotEmpty && search.text.length > 1)
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.15,
                            horizontal: 16),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // print(destinationPredictionList[index].mainText.toString());
                                getPlaceDetails(destinationPredictionList[index]
                                    .placeId as String);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.location_on,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                destinationPredictionList[index]
                                                    .mainText as String,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                destinationPredictionList[index]
                                                    .secondaryText as String,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: destinationPredictionList.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                        ),
                      )
                    : Container(),
          )
        ]));
  }

  getPlaceName() async {
    var placeNameTripTo = await HelperMethods.findCordinateAdress(
        Position(
          longitude: cameraPosition!.target.longitude,
          latitude: cameraPosition!.target.latitude,
          timestamp: null,
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
        context,
        mapLanguage,
        widget.apiKey);

    setState(() {
      //get place name from lat and lang
      search.clear();
      locationName = placeNameTripTo;
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition!));
      pin = true;
    });
  }

  void getPlaceDetails(String placeID) async {
    Alerts.loading(context,);

    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=${widget.apiKey}';

    var response = await RequestHelper.getRequest(url);

     Navigator.pop(context);

    if (response == 'failed') {
      return;
    }

    if (response['status'] == 'OK') {
      Address thisPlace = Address();
      thisPlace.placeName = response['result']['name'];
      thisPlace.placeId = placeID;
      thisPlace.latitude = response['result']['geometry']['location']['lat'];
      thisPlace.longitude = response['result']['geometry']['location']['lng'];

      FocusManager.instance.primaryFocus?.unfocus();

      setState(() {
        cameraPosition = CameraPosition(
            zoom: 18,
            target: LatLng(thisPlace.latitude!.toDouble(),
                thisPlace.longitude!.toDouble()));
      });
      getPlaceName();
    }
  }

  searchPlace(String placeName) async {
    if (placeName.length > 1) {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${widget.apiKey}&sessiontoken=123254251&components=country:om';
      var response = await RequestHelper.getRequest(url);
// print(response['status']);
      if (response == 'failed') {
        return 'err';
      }

      if (response['status'] == 'OK') {
        var predictionJson = response['predictions'];
        var thisList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();

        setState(() {
          destinationPredictionList = thisList;
        });
      }
    }
  }
}

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes.dart';
import 'helper/helper_class.dart';
import 'helper/req_helper.dart';
import 'helper/text.dart';
import 'helper/win.dart';

class MapPicker extends StatefulWidget {
  MapPicker({
    Key? key,
    this.startLocation,
    required this.primaryPickerMark,
    required this.secondaryPickerMark,
    required this.onPin,
    this.inputText,
    this.mapType,
    required this.apiKey,
    this.mapLanguage,
    this.inputIcon,
    this.textInputColor,
    this.sendBtnIcon,
    this.searchBoxHintText,
    this.userMapType,
  }) : super(key: key);

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  /// ### Here add the starting location, this location will appear directly when entering the widget

  /// #### You can leave it blank and it will use a default location

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  ///
  ///
  ///### هنا قم بإضافة موقع البدء ، سوف يظهر هذا الموقع مباشرة عند الدخول للويدجت

  ///#### بإمكانك تركه فارغا وسوف يستعمل موقع افتراضي

  final LatLng? startLocation;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here, type the text that appears below before choosing a location, you can leave it blank

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا قم بكتابة النص الذي يظهر بالاسفل قبل اختيار الموقع, بإمكانك تركه فارغا
  final String? inputText;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here is the widget that will appear in the submit button

  ///#### You can leave it blank and it will use the default send icon
  ///
  ///
  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا الويدجت الذي سوف يظهر في زر الارسال

  ///#### بإمكانك تركه فارغا وسوف يستعمل ايقونة الارسال الافتراضية

  final Widget? sendBtnIcon;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  ///
  ///### Here is the text color of the text box,

  /// #### it is black by default

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا لون النص الخاص بمربع النص ،

  ///#### لونه اسود بشكل افتراضي

  final Color? textInputColor;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here is the icon that appears next to the text box for the position name, at the bottom

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  ///
  ///### هنا الأيقونة التي تظهر بجانب مربع النص الخاص باسم الموقع، في الاسفل

  final Widget? inputIcon;
  
  /// this [primaryPickerMark] widget is used to mark the pinned location by user
  final Widget primaryPickerMark;

  /// this [secondaryPickerMark] widget is used as a mobile indicator to pin the location
  final Widget secondaryPickerMark;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### This String is required and mandatory, here  type your API key from Google Cloud

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هذا الString مطلوب و جباري، هنا  مفتاح الAPI الخاص بك من Google Cloud
  final String apiKey;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here is the text that will appear in the search box at the top

  ///#### default phrase (Search For A Place)

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا النص الذي سوف يظهر في مربع البحث في الأعلى

  ///#### العبارة الافتراضية (Search For A Place)
  final String? searchBoxHintText;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here is the language of the map and the name of the places, just type the language code

  ///#### For example: for Arabic (ar) for English (en)

  ///#### You can leave it blank and it will be in English by default

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا لغة الخريطة و اسم الاماكن ، اكتب رمز اللغة فقط

  ///#### مثلا : للعربية (ar) للانجليزية (en)

  ///#### بامكانك تركها فارغة وسوف تكون بالانجليزية بشكل افتراضي
  final String? mapLanguage;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here is type of the map, if it is normal, satellite, etc

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا نوع الخريطة اذا كانت افتراضية او قمر صناعي وغيره
  final MapType? mapType;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here If you want show or hide map type button for the users
  ///
  ///#### It's true by default
  ///
  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا اذا كنت تريد أظهار زر تغيير نوع الخريطة للمستخدمين

  /// #### حاليا مفعل بشكل افتراضي
  final bool? userMapType;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>

  ///### Here comes the data after selecting the location, including the name of the place and its LatLng
  ///
  ///
  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  ///### هنا تأتي البيانات بعد اختيار الموقع بداخله اسم المكان و الLatLng الخاص به
  final void Function(PinData pinData) onPin;

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late LatLng startLocation =
      widget.startLocation ?? const LatLng(23.5838126, 58.38648);
  late String mapLanguage = widget.mapLanguage ?? 'en';
  late bool userMapType = widget.userMapType ?? true;
  late String searchBoxHintText =
      widget.searchBoxHintText ?? 'Search For A Place';
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
              child:
                  pin
              ? widget.primaryPickerMark : widget.secondaryPickerMark),
          Visibility(
            visible: userMapType,
            child: Positioned(
                //widget to display location name
                right: 10,
                top: 200,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        mapType != MapType.hybrid
                            ? mapType = MapType.hybrid
                            : mapType = MapType.normal;
                      });
                    },
                    icon: Icon(
                      Icons.layers_rounded,
                      color: inputColor,
                      size: 25,
                    ),
                  ),
                )),
          ),
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
                        hintText: searchBoxHintText),
                    controller: search,
                    onChanged: (value) {
                      searchPlace(value);
                    },
                  ),
                ),
              )),
          Positioned(
            // top: 150,
            child: (destinationPredictionList.isNotEmpty &&
                    search.text.length > 1)
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
                                            style:
                                                const TextStyle(fontSize: 16),
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
                                const SizedBox(
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
    Alerts.loading(
      context,
    );

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

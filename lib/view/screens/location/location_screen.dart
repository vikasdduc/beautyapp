import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/location_model.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  late Future<LocationModel?> location;
  @override
  void initState() {
    location = DioClient.instance.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHOOSE LOCATION",
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Please select your city",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.fontSizeOverLarge,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          FutureBuilder(
            future: location,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Color(0xFFA854FC),);
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<Loction> locationData;
                if (snapshot.hasData && snapshot.data!.status == "success") {
                  locationData = snapshot.data?.loction ?? [];
                  return Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: locationData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Auth.instance.prefs.setString(
                                "selectedLocation",
                                locationData[index].city?.toLowerCase() ??
                                    "lucknow");
                            Auth.instance.prefs.setInt("selectedLocationId",
                                locationData[index].id ?? 2);
                            Navigator.of(context).popAndPushNamed("/dashboard");
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                    locationData[index].imageBaseUrl ?? ""),
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              locationData[index]
                                                      .imageBaseUrl ??
                                                  "")),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  locationData[index].city ?? "",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const CustomError();
                }
              } else {
                return const CustomError();
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/data/model/packages_model/preferred_pack_model.dart';
import 'package:glamcode/view/base/package_tile.dart';

class Packages extends StatefulWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  late Future<PreferredPackModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getPreferredPack();
    print(_future);
    
    super.initState();
    FacebookAppEvents facebookAppEvents = FacebookAppEvents();
    facebookAppEvents.logEvent(
      name: 'Service Page',
      parameters: {
        'visited Service Page': 'visited Service Page',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const Center(
          child: Text(
            "Offers & Deals ",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
        const Divider(
          height: 10,
        ),
        FutureBuilder<PreferredPackModel?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const Center(
                //     child: CircularProgressIndicator(
                //   color: Color(0xFFA854FC),
                // ));
                return dummyListviewCell();
              } else if (snapshot.connectionState == ConnectionState.done) {
                PreferredPackModel preferredPackData =
                    const PreferredPackModel();
                if (snapshot.hasData) {
                  preferredPackData = snapshot.data!;
                }
                List<ServicePackage> preferredPackList =
                    preferredPackData.preferredPack ?? [];
                return ListView.builder(
                  key: UniqueKey(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: preferredPackList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PackageTile(
                      servicePackage: preferredPackList[index],
                    );
                  },
                );
              } else {
                // return const CustomError();
                return Container();
              }
            })
      ],
    );
  }
}

Widget dummyListviewCell() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0, top: 15),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 8,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ),
        ],
      )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.white,
        ),
      ),
    ]),
  );
}

import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/data/model/packages_model/preferred_pack_model.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
     const   Divider(),
      const  Center(
          child: Text(
            "Offers & Deals ",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
       const Divider(),
        FutureBuilder<PreferredPackModel?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFA854FC),
                ));
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

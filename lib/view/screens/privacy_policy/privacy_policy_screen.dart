import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/privacy.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late Future<Privacy?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getPrivacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<Privacy?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            Privacy privacy = Privacy();
            if (snapshot.hasData) {
              privacy = snapshot.data!;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: HtmlWidget(privacy.pageData.toString()),
                  ),
                ),
              );
            } else {
              return const CustomError();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

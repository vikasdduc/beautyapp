import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/about.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<About?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getAbout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Glam Code"),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<About?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            About about = About();
            if (snapshot.hasData) {
              about = snapshot.data!;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: HtmlWidget(about.pageData.toString()),
                  ),
                ),
              );
            }else {
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

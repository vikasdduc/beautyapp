import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/terms.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  late Future<TermsModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getTerms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<TermsModel?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            TermsModel termsModel = TermsModel();
            if (snapshot.hasData) {
              termsModel = snapshot.data!;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: HtmlWidget(termsModel.pageData.toString()),
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

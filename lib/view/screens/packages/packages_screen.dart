import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/packages_model/packages_category.dart';
import 'package:glamcode/data/model/packages_model/packages_model.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/bottomServiceBar.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/home/widget/services_grid.dart';

class PackagesScreen extends StatefulWidget {
  final int mainCategoryId;
  final String mainCategoryName;

  const PackagesScreen(
      {Key? key, required this.mainCategoryId, required this.mainCategoryName})
      : super(key: key);

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen>
    with TickerProviderStateMixin {
  late Future<PackagesModel?> _future;
  List<PackagesCategory> packagesCategory = [];
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    _future = DioClient.instance.getAllPackages(
      widget.mainCategoryId,
    );
    //  _future = DioClient.instance.getAllPackages(widget.mainCategoryName);

    _tabController =
        TabController(length: packagesCategory.length, vsync: this);
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackagesModel?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          PackagesModel packagesModelData = const PackagesModel();
          if (snapshot.hasData) {
            packagesModelData = snapshot.data!;
            packagesCategory = packagesModelData.categories ?? [];
            List<Widget> tabTitles = [];
            for (var e in packagesCategory) {
              tabTitles.add(Text(
                e.name ?? "",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ));
            }
            _tabController =
                TabController(length: tabTitles.length, vsync: this);
            return Scaffold(
              backgroundColor: const Color(0xFFFFF1F1),
              appBar: AppBar(
                /*leading: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                  ],
                ),
              ),*/
                titleSpacing: 0,
                backgroundColor: Colors.white,
                title: Text(
                  "     ${widget.mainCategoryName.toString()}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                bottom: TabBar(
                  enableFeedback: true,
                  controller: _tabController,
                  labelColor: const Color(0xFFAB54FC),
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  labelPadding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(0, 255, 255, 255)),
                  tabs: tabTitles,
                  onTap: (int index) {
                    _pageController.jumpToPage(index);
                  },
                ),
              ),
              body: PageView.builder(
                controller: _pageController,
                itemCount: packagesCategory.length,
                itemBuilder: (context, index) {
                  return packagesTabScreen(packagesCategory[index]);
                },
                onPageChanged: (int index) {
                  _tabController.index = index;
                },
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(20),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20)), //this right here
                            child: const SizedBox(child: ServicesGrid()),
                          );
                        });
                  },
                  label: const Text("Menu"),
                  icon: const Icon(
                    Icons.grid_view_rounded,
                    color: Color(0xFFAB54FC),
                  ),
                ),
              ),
              bottomNavigationBar: const BottomServiceBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterFloat,
            );
          } else {
            return const Scaffold(
              body: CustomError(),
            );
          }
        } else {
          return const Scaffold(
            body: CustomError(),
          );
        }
      },
    );
  }
}

Widget packagesTabScreen(PackagesCategory packagesCategory) {
  List<ServicePackage>? serviceList = packagesCategory.service ?? [];
  return ListView.builder(
    itemCount: serviceList.length,
    itemBuilder: (BuildContext context, int index) {
      return PackageTile(
        servicePackage: serviceList[index],
      );
    },
  );
}

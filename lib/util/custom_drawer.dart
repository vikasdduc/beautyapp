import 'package:flutter/material.dart';
import 'package:glamcode/util/delete_my_account.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/refertoearn/invitetoearn.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';
import 'package:glamcode/view/screens/profile/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xE38F63BA), Color(0xFFD9BEF4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView(
          children: [
            DrawerHeader(
                child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    'assets/images/app_icon_circular.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
            drawerTile("Home", Icons.home_filled, () {
              Navigator.of(context).pop();
            }, context),
            drawerTile("My Account", Icons.person, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          const DashboardScreen(pageIndex: 3)),
                  ModalRoute.withName('/index'));
            }, context), //removed membership
            drawerTile("Blog", Icons.comment_bank, null, context),
            drawerTile("Wallet", Icons.wallet, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          const DashboardScreen(pageIndex: 1)),
                  ModalRoute.withName('/index'));
            }, context),
            drawerTile("About Us", Icons.info, () {
              Navigator.of(context).popAndPushNamed('/about');
            }, context),
            drawerTile("Contact", Icons.phone, () async {
              await launchLink("mailto:info@glamcode.in");
            }, context),
            drawerTile("Cart", Icons.shopping_cart, () {
              Navigator.of(context).popAndPushNamed('/cart');
            }, context),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InviteToEarn()));
              },
              child: drawerTile(
                  "Refer and Earn", Icons.attach_money_rounded, null, context),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DeleteMyAccount()));
              },
              child:
                  drawerTile("Delete My Account", Icons.delete, null, context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget drawerTile(
    String title, IconData icon, Function()? fn, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              spreadRadius: 0.1,
              blurRadius: 3,
            )
          ]),
      child: ListTile(
        onTap: fn,
        dense: true,
        style: ListTileStyle.drawer,
        horizontalTitleGap: 0,
        title: Text(
          title,
          style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
        ),
        leading: Icon(icon),
      ),
    ),
  );
}

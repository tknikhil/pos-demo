import 'package:flutter/material.dart';
import 'package:pos_demo/core/extensions/responsive_ext.dart';
import 'package:pos_demo/features/pos/presentation/widgets/helpers.dart';
import 'package:pos_demo/main.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  // Initialize scaffoldKey at the class level
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Attach scaffoldKey here
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        leading: IconButton(
          padding: const EdgeInsets.all(0),
          icon: logo(), // Use your custom logo widget here
          onPressed: () {
            scaffoldKey.currentState
                ?.openDrawer(); // Open the drawer using the global key
          },
        ),
      ),
      drawer: Drawer(
        child: SideMenu(
          pageActive: '',
          onPageChange: (String page) {
            // Your page change logic goes here
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            context.isDesktop ? desktopView(context) : mobileOrTabView(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pos_demo/core/extensions/responsive_ext.dart';
import 'package:pos_demo/features/pos/presentation/screens/pos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageActive = 'Home'; // Move the pageActive here for managing state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: context.isDesktop ? desktopView(context) : mobileView(),
    );
  }

  Expanded mainPage() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 24, right: 12),
        padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Color.fromARGB(255, 248, 248, 248),
        ),
        child: _pageView(),
      ),
    );
  }

  Row desktopView(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
          height: context.height,
          child: SideMenu(
            pageActive: pageActive,
            onPageChange: (newPage) {
              setState(() {
                pageActive = newPage;
              });
            },
          ),
        ),
        mainPage(),
      ],
    );
  }

  Expanded mobileView() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 24, right: 12),
        padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Color.fromARGB(255, 248, 248, 248),
        ),
        child: _pageView(),
      ),
    );
  }

  Widget _pageView() {
    switch (pageActive) {
      case 'Home':
        return const PosScreen();
      case 'Menu':
        return Container();
      case 'History':
        return Container();
      case 'Promos':
        return Container();
      case 'Settings':
        return Container();

      default:
        return const PosScreen();
    }
  }
}

class SideMenu extends StatelessWidget {
  final String pageActive;
  final Function(String) onPageChange;

  const SideMenu({
    super.key,
    required this.pageActive,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        logo(),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            children: [
              _itemMenu(menu: 'Home', icon: Icons.rocket_sharp),
              _itemMenu(menu: 'Menu', icon: Icons.format_list_bulleted_rounded),
              _itemMenu(
                  menu: 'History', icon: Icons.history_toggle_off_rounded),
              _itemMenu(menu: 'Promos', icon: Icons.discount_outlined),
              _itemMenu(menu: 'Settings', icon: Icons.sports_soccer_outlined),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemMenu({required String menu, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: GestureDetector(
        onTap: () => onPageChange(menu),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: pageActive == menu
                  ? const Color(0xFF094F90)
                  : Colors.transparent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.slowMiddle,
            child: Column(
              children: [
                Icon(
                  icon,
                  color: pageActive == menu
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF474747),
                ),
                const SizedBox(height: 5),
                Text(
                  menu,
                  style: TextStyle(
                      color: pageActive == menu
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF474747),
                      fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget logo() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF094F90),
        ),
        child: const Icon(
          Icons.fastfood,
          color: Color(0xFFFFFFFF),
          size: 14,
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'POSFood',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

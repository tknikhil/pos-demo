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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedGridOption =
      0; // 0 for 1 column, 1 for 2 columns, 2 for 4 columns

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !context.isDesktop
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(context.width, 200),
                  minimumSize: Size(context.width, 45),
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xFF319626),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Adjust this value for less/more radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(
                        child: orderTotals(),
                      ),
                    ),
                  );
                },
                child: const Text("Cart"),
              ),
            )
          : const SizedBox.shrink(),
      appBar: AppBar(
        leadingWidth: context.isDesktop ? 0 : 50,
        title: context.isDesktop
            ? topMenu(
                title: 'Lorem Restaurant',
                subTitle: '20 October 2022',
                action: search(),
              )
            : const SizedBox.shrink(),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        leading: IconButton(
          padding: const EdgeInsets.all(0),
          icon: context.isDesktop
              ? const SizedBox.shrink()
              : logo(), // Custom logo widget
          onPressed: () {
            scaffoldKey.currentState?.openDrawer(); // Open drawer
          },
        ),
        actions: [
          _buildGridSegmentedControl(),
        ],
      ),
      drawer: Drawer(
        child: SideMenu(
          pageActive: '',
          onPageChange: (String page) {
            // Handle page change
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

  Row desktopView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 14,
          child: Column(
            children: [
              topTab(),
              productGrid(context),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        orderTotals(),
      ],
    );
  }

  Column mobileOrTabView(BuildContext context) {
    return Column(
      children: [
        topTab(),
        productGrid(context),
      ],
    );
  }

  Widget _buildGridSegmentedControl() {
    // Define the list of children widgets based on the device type
    List<Widget> children = [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Icon(Icons.grid_3x3, size: 24), // 2 Columns icon
      ),
    ];

    if (context.isMobile) {
      children.insert(
        0,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(Icons.grid_view, size: 24), // 1 Column icon
        ),
      );
    }

    // Add the 4x4 grid icon for desktop only
    if (context.isDesktop || context.isTablet) {
      children.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(Icons.grid_4x4, size: 24), // 4 Columns icon for desktop
        ),
      );
    }

    // Adjust the isSelected list to match the number of children
    List<bool> isSelected = List.generate(children.length, (index) {
      return index == _selectedGridOption;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            _selectedGridOption = index;
          });
        },
        children: children,
      ),
    );
  }

  Expanded productGrid(BuildContext context) {
    int crossAxisCount;
    double childAspectRatio;

    switch (_selectedGridOption) {
      case 1: // 2 columns
        crossAxisCount = (context.isDesktop || context.isTablet) ? 4 : 2;
        childAspectRatio = context.isTablet ? (1 / 1.4) : (1);
        break;
      case 2: // 4 columns
        crossAxisCount = 4;
        childAspectRatio = context.isDesktop ? (1 / 1.2) : (1 / 1.4);
        break;
      default: // 1 column
        crossAxisCount = (context.isDesktop || context.isTablet) ? 2 : 1;
        childAspectRatio = 1;
        break;
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        children: [
          _item(
              image: 'items/1.png',
              title: 'Original Burger',
              price: '\$5.99',
              item: '11 item'),
          _item(
              image: 'items/2.png',
              title: 'Double Burger',
              price: '\$10.99',
              item: '10 item'),
          _item(
              image: 'items/3.png',
              title: 'Cheese Burger',
              price: '\$6.99',
              item: '7 item'),
          _item(
              image: 'items/4.png',
              title: 'Double Cheese Burger',
              price: '\$12.99',
              item: '20 item'),
          _item(
              image: 'items/5.png',
              title: 'Spicy Burger',
              price: '\$7.39',
              item: '12 item'),
          _item(
              image: 'items/6.png',
              title: 'Special Black Burger',
              price: '\$7.39',
              item: '39 item'),
          _item(
              image: 'items/7.png',
              title: 'Special Cheese Burger',
              price: '\$8.00',
              item: '2 item'),
          _item(
              image: 'items/8.png',
              title: 'Jumbo Cheese Burger',
              price: '\$15.99',
              item: '2 item'),
          _item(
              image: 'items/9.png',
              title: 'Spicy Burger',
              price: '\$7.39',
              item: '12 item'),
          _item(
              image: 'items/10.png',
              title: 'Special Black Burger',
              price: '\$7.39',
              item: '39 item'),
          _item(
              image: 'items/11.png',
              title: 'Special Cheese Burger',
              price: '\$8.00',
              item: '2 item'),
          _item(
              image: 'items/12.png',
              title: 'Jumbo Cheese Burger',
              price: '\$15.99',
              item: '2 item'),
        ],
      ),
    );
  }

  Container topTab() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _itemTab(
              icon: 'icons/icon-burger.png', title: 'Burger', isActive: true),
          _itemTab(
              icon: 'icons/icon-noodles.png',
              title: 'Noodles',
              isActive: false),
          _itemTab(
              icon: 'icons/icon-drinks.png', title: 'Drinks', isActive: false),
          _itemTab(
              icon: 'icons/icon-desserts.png',
              title: 'Desserts',
              isActive: false),
        ],
      ),
    );
  }

  Expanded orderTotals() {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          topMenu(title: 'Order', subTitle: 'Table 8', action: Container()),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                _itemOrder(
                    image: 'items/1.png',
                    title: 'Original Burger',
                    qty: '2',
                    price: '\$5.99'),
                _itemOrder(
                    image: 'items/2.png',
                    title: 'Double Burger',
                    qty: '3',
                    price: '\$10.99'),
                _itemOrder(
                    image: 'items/6.png',
                    title: 'Special Black Burger',
                    qty: '2',
                    price: '\$8.00'),
                _itemOrder(
                    image: 'items/4.png',
                    title: 'Special Cheese Burger',
                    qty: '2',
                    price: '\$12.99'),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFFFFFFFF),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                      Text('\$40.32',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                      Text('\$4.32',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                    ],
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 20),
                  //   height: 2,
                  //   width: double.infinity,
                  //   color: const Color(0xFFFFFFFF),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                      Text('\$44.64',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF474747))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFFFFFFF),
                        backgroundColor: const Color(0xFF319626),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print, size: 16),
                          SizedBox(width: 6),
                          Text('Print Bills')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemOrder(
      {required String image,
      required String title,
      required String qty,
      required String price}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFFFFFFFF),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF474747))),
                const SizedBox(height: 10),
                Text(price,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF474747))),
              ],
            ),
          ),
          Text('$qty x',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF474747))),
        ],
      ),
    );
  }

  Widget _item({
    required String image,
    required String title,
    required String price,
    required String item,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF474747),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF094F90),
                  fontSize: 20,
                ),
              ),
              Text(
                item,
                style: const TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemTab(
      {required String icon, required String title, required bool isActive}) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 26),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
        border: isActive
            ? Border.all(color: const Color(0xFF094F90), width: 3)
            : Border.all(
                color: const Color.fromARGB(255, 175, 175, 175), width: 3),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.food_bank,
            color: Color(0xFF094F90),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF474747),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  final Widget child; // Use Widget instead of Expanded

  const OrderPage({super.key, required this.child});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.child,
    )); // Remove the const keyword
  }
}

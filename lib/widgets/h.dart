import 'package:estoregpt/features/admin/screens/login_screen.dart';
import 'package:estoregpt/features/search/screens/search_screen.dart';
import 'package:estoregpt/providers/drawer_provider.dart';
import 'package:estoregpt/widgets/height_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String route = "/home";

  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = [
    const SearchScreen(),
    const SendPushNotificationsScreen(),
  ];

  late PageController _pageController;

  int _currentIndex = 0;

  void _changePage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
    // Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: Provider.of<DrawerProvider>(context, listen: false).scaffoldKey,
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: const Color(0xFFf1eef7),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Stack(
                children: [
                  ListTile(
                    title: const Text(
                      'E-StoreGPT',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    selected: _currentIndex == 0,
                    onTap: () => _changePage(0),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.route);
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: 60,
                        // width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Add Products",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const HeightSpace(20),
                ],
              ),
            ),
      // appBar: isDesktop
      //     ? null
      //     : AppBar(
      //         toolbarHeight: 30,
      //         leading: isDesktop
      //             ? null
      //             : IconButton(
      //                 icon: const Icon(Icons.menu),
      //                 onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      //               ),
      //       ),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: width * 0.23,
              child: Drawer(
                backgroundColor: const Color(0xFFf1eef7),
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      title: const Text(
                        'E-StoreGPT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: _currentIndex == 0,
                      onTap: () => _changePage(0),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.route);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: 60,
                          // width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "Add Products",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  static const String route = "/dashboard";
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SendPushNotificationsScreen extends StatelessWidget {
  static const String route = "/send";
  const SendPushNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

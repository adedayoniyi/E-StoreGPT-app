import 'package:estoregpt/config/routes/router.dart';
import 'package:estoregpt/features/admin/providers/user_provider.dart';
import 'package:estoregpt/providers/drawer_provider.dart';
import 'package:estoregpt/widgets/h.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(const Duration(seconds: 1));
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 800, tablet: 600, watch: 200),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return DrawerProvider();
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFf1eef7),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
      onGenerateRoute: (settings) => appRoutes(settings),
      // routerDelegate: AppRouterDelegate(),
      // routeInformationParser: AppRouteInformationParser(),
    );
  }
}

// class MyImage extends StatefulWidget {
//   @override
//   _MyImageState createState() => _MyImageState();
// }

// class _MyImageState extends State<MyImage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RotationTransition(
//       turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
//       child: Image.asset(
//         'assets/images/test_logo 1 1.png',
//         height: 1,
//         width: 1,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class AppRoutePath {
//   final String route;
//   AppRoutePath(this.route);
// }

// class AppRouterDelegate extends RouterDelegate<String>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
//   final GlobalKey<NavigatorState> navigatorKey;
//   String currentRoute = '/home';

//   AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   String get currentConfiguration => currentRoute;

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = MediaQuery.of(context).size.width > 800;
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//           child: HomeScreen(
//             currentRoute: currentRoute,
//             onNavigate: _handleNavigate,
//             isDesktop: isDesktop,
//             scaffoldKey: _scaffoldKey,
//           ),
//         ),
//       ],
//       onPopPage: (route, result) {
//         return route.didPop(result);
//       },
//     );
//   }

//   void _handleNavigate(String route) {
//     currentRoute = route;
//     notifyListeners();
//   }

//   @override
//   Future<void> setNewRoutePath(String path) async {
//     currentRoute = path;
//   }
// }

// class AppRouteInformationParser extends RouteInformationParser<String> {
//   @override
//   Future<String> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     return routeInformation.location ?? '/home';
//   }

//   @override
//   RouteInformation restoreRouteInformation(String path) {
//     return RouteInformation(location: path);
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final String currentRoute;
//   final Function(String) onNavigate;
//   final bool isDesktop;
//   final GlobalKey<ScaffoldState> scaffoldKey;

//   HomeScreen({
//     required this.currentRoute,
//     required this.onNavigate,
//     required this.isDesktop,
//     required this.scaffoldKey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       drawer: isDesktop ? null : _buildDrawer(),
//       appBar: isDesktop
//           ? null
//           : AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.menu),
//                 onPressed: () => scaffoldKey.currentState!.openDrawer(),
//               ),
//             ),
//       body: Row(
//         children: [
//           if (isDesktop) _buildDrawer(),
//           Expanded(
//             child: _buildBody(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         children: [
//           ListTile(
//             title: Text('Dashboard'),
//             onTap: () => onNavigate('/dashboard'),
//           ),
//           ListTile(
//             title: Text('Search'),
//             onTap: () => onNavigate('/search'),
//           ),
//           ListTile(
//             title: Text('Send Notifications'),
//             onTap: () => onNavigate('/send_notifications'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody() {
//     switch (currentRoute) {
//       case '/dashboard':
//         return DashboardScreen();
//       case '/search':
//         return SearchScreen();
//       case '/send_notifications':
//         return SendPushNotificationsScreen();
//       default:
//         return Text('Unknown route: $currentRoute');
//     }
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('This is the Dashboard Screen'),
//       ),
//     );
//   }
// }

// class SendPushNotificationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('This is the notification Screen'),
//       ),
//     );
//   }
// }

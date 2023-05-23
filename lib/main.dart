import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screen/Cart.dart';
import 'package:store/screen/Favorite.dart';
import 'package:store/screen/Home.dart';
import 'package:store/screen/Login.dart';
import 'package:store/screen/PaymentMethod.dart';

import 'Provider/CartProvider.dart';
import 'Provider/FavoriteProvider.dart';
import 'component/CustomDrawer.dart';
import 'Provider/LoginState.dart';

List<BottomNavigationBarItem> bottomNavItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Akey',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    label: 'Favori',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart),
    label: 'Panye',
  ),
];

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => LoginState()),
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
      debugShowCheckedModeBanner: false,
      title: 'Magazen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: "Magazen"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context, listen: true);

    Widget currentScreen() {
      switch (selectedIndex) {
        case 0:
          return const HomePage();
        case 1:
          return FavoritesScreen();
        case 2:
          return CartScreen();
        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (!loginState.isLoggedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodListView(),
                  ),
                );
              }
            },
            child: const Text('Peye'),
          ),
        ],
      ),
      drawer: CustomDrawer(
        isLoggedIn: loginState.isLoggedIn,
        user: loginState.user,
      ),
      body: currentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

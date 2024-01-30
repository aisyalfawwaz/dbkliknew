import 'package:dbkliknew/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure that super.build is called

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          // Replace with the corresponding widgets for each menu item
          HomePage(),
          CategoriesPage(),
          CartPage(),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: PhysicalModel(
        color: Colors.white,
        elevation: 8.0,
        shadowColor: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            unselectedItemColor:
                Color.fromARGB(255, 128, 131, 128), // Set unselected item color
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.menu),
                title: const Text('Categories'),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.shopping_cart),
                title: const Text('Cart'),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                selectedColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories Page'),
      ),
      body: Center(
        child: Text('Categories Page Content'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Text('Cart Page Content'),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Page'),
      ),
      body: Center(
        child: Text('Favorites Page Content'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}

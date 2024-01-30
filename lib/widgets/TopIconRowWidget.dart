import 'package:badges/badges.dart' as badges;
import 'package:dbkliknew/screens/CartsPage.dart';
import 'package:dbkliknew/screens/SearchDetail.dart';
import 'package:dbkliknew/screens/WishlistPage.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';

class TopIconRowWidget extends StatelessWidget {
  final BuildContext context;

  TopIconRowWidget({required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        onSubmitted: (query) => _handleSearch(context, query),
                        decoration: InputDecoration(
                          hintText: 'Cari di DBKlik',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            // Icons with badges
            _buildBadgedIconButton(
                Icons.email, Colors.blue, _handleEmailAction, 1),
            _buildBadgedIconButton(
                Icons.favorite, Colors.blue, _handleNotificationAction, 2),
            _buildBadgedIconButton(
                Icons.shopping_cart, Colors.blue, _handleShoppingCartAction, 5),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgedIconButton(
      IconData icon, Color iconColor, Function onPressed, int badgeCount) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -5, end: -1),
      badgeContent: Text(
        badgeCount.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: () => onPressed(context, badgeCount),
      ),
    );
  }

  void _handleEmailAction(BuildContext context, int badgeCount) {
    // Handle email action
    print('Email action - Badge Count: $badgeCount');
  }

  void _handleNotificationAction(BuildContext context, int badgeCount) {
    // Handle notification action
    print('Notification action - Badge Count: $badgeCount');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WishlistPage()),
    );
  }

  Future<void> _handleShoppingCartAction(
      BuildContext context, int badgeCount) async {
    try {
      // Fetch the user ID from the API
      int userId = await ApiService().getUserId();

      // Handle shopping cart action with the obtained user ID
      print(
          'Shopping cart action - Badge Count: $badgeCount, User ID: $userId');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartsPage(userId)),
      );
    } catch (error) {
      print('Error fetching user ID: $error');
    }
  }

  Future<void> _handleSearch(BuildContext context, String query) async {
    try {
      // Store the context in a variable
      final currentContext = context;

      // Pemanggilan API pencarian tanpa offset
      final searchResults = await ApiService().searchProducts(query);

      // Handle hasil pencarian sesuai kebutuhan
      print(query);
      print('Search result: $searchResults');

      // Navigasi ke halaman pencarian dengan membawa query
      Navigator.push(
        currentContext,
        MaterialPageRoute(
          builder: (context) => SearchDetail(searchResults: searchResults),
        ),
      );
    } catch (error) {
      print('Error during search: $error');
    }
  }
}

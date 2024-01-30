import 'package:dbkliknew/screens/DetailProductPage.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, dynamic>> wishlistData = [];
  int userId = 0; // Initialize userId to 0
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch wishlist data when the page is loaded
    fetchUserIdAndWishlistData();
  }

  Future<void> fetchUserIdAndWishlistData() async {
    // Fetch the user ID from the API
    userId = await ApiService().getUserId();

    // Fetch wishlist data based on the obtained user ID
    wishlistData = await ApiService().getWishlistData(userId);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteWishlistItem(int productId) async {
    try {
      // Delete wishlist item based on user ID and product ID
      await ApiService().deleteWishlistItem(userId, productId);

      // Fetch updated wishlist data after deletion
      wishlistData = await ApiService().getWishlistData(userId);

      // Show a Snackbar when successfully removed from the wishlist
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product removed from wishlist'),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {});
    } catch (error) {
      print('Error deleting wishlist item: $error');
      // Show a Snackbar when an error occurs during deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove product from wishlist'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: isLoading
          ? Center(
              // Display a blue circular progress indicator while loading
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : wishlistData.isNotEmpty
              ? ListView.builder(
                  itemCount: wishlistData.length * 2 - 1,
                  itemBuilder: (context, index) {
                    if (index.isOdd) {
                      // If index is odd, return a styled Divider
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 1,
                        color: const Color.fromARGB(255, 224, 224, 224),
                      );
                    } else {
                      // If index is even, calculate product index
                      final productIndex = index ~/ 2;

                      if (productIndex < wishlistData.length) {
                        // Check if productIndex is within the valid range
                        final product = wishlistData[productIndex];
                        final numberFormat = NumberFormat.currency(
                            locale: 'id_ID', symbol: 'Rp');

                        return ListTile(
                          title: Text(product['name'] ?? ''),
                          subtitle: Text(
                              'Harga : ${numberFormat.format(product['price'] ?? 0)}'),
                          leading: Image.network(product['img'] ?? ''),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              // Call the deleteWishlistItem method
                              deleteWishlistItem(product['id']);
                            },
                          ),
                        );
                      } else {
                        // Handle the case where the productIndex is out of range
                        return SizedBox
                            .shrink(); // or any other widget as needed
                      }
                    }
                  },
                )
              : Center(
                  // Display a message when the wishlist is empty
                  child: Text('Wishlist is empty.'),
                ),
    );
  }
}

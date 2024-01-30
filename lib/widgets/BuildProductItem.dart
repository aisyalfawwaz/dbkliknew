// build_product_item.dart
import 'package:dbkliknew/screens/DetailProductPage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:money_formatter/money_formatter.dart';

Widget buildProductItem(BuildContext context, Map<String, dynamic> product,
    {double? cardHeight}) {
  return GestureDetector(
    onTap: () {
      // Implement navigation to detail product page here
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailProductPage(product)));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.blue, // Set the desired border color
          width: 1.0, // Set the desired border width
        ),
      ),
      child: Card(
        margin: EdgeInsets.zero, // Set margin to zero to remove extra padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0), // Adjust the inner radius
        ),
        color: Colors.white, // Set the background color to white
        child: SizedBox(
          height: cardHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProductImage(product['external_link'] ?? ''),
              _buildProductName(product['name'] ?? ''),
              _buildProductPrice(product['unit_price'] ?? 0),
              _buildNumOfSale(product['num_of_sale'] ?? 0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ... (rest of the code remains unchanged)

Widget _buildProductImage(String imageUrl) {
  return AspectRatio(
    aspectRatio: 1 / 1, // Adjust the aspect ratio as needed
    child: ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(14.0)), // Adjust the inner radius
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ),
  );
}

Widget _buildProductName(String name) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 12.0,
      ),
      maxLines: 2,
    ),
  );
}

Widget _buildNumOfSale(int numOfSale) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      'Terjual: $numOfSale',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
      ),
    ),
  );
}

Widget _buildProductPrice(int price) {
  MoneyFormatterOutput fmf = MoneyFormatter(amount: price.toDouble())
      .output; // Convert price to double before using

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      'Rp ${fmf.nonSymbol}', // Use nonSymbol for the formatted amount
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
  );
}

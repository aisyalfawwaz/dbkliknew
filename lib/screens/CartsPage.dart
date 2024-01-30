import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartsPage extends StatefulWidget {
  final int userId;

  CartsPage(this.userId);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartsPage> {
  List<Map<String, dynamic>> cartData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    cartData = await ApiService().getCartData(widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : cartData.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          final product = cartData[index];
                          return _buildCartItem(product);
                        },
                      ),
                    ),
                    _buildTotalPrice(),
                    _buildCheckoutButton(),
                  ],
                )
              : Center(
                  child: Text('Your cart is empty.'),
                ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> product) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    final formattedPrice = formatter.format(product['price'] ?? 0);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product['pic'] ?? '',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(product['name'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              'Harga : $formattedPrice',
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(height: 4),
            Text(
              'Jumlah : ${product['qty'] ?? 0}',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Implement your delete item functionality here
          },
        ),
      ),
    );
  }

  Widget _buildTotalPrice() {
    double totalPrice = cartData
        .map<double>((product) =>
            (product['price'] ?? 0).toDouble() *
            (product['qty'] ?? 0).toDouble())
        .reduce((value, element) => value + element);

    // Format totalPrice as Indonesian Rupiah
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    final formattedTotalPrice = formatter.format(totalPrice);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Harga Total',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            formattedTotalPrice,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          // Implement your checkout functionality here
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          'Checkout',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

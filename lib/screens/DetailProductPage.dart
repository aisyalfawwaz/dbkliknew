import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  DetailProductPage(this.product);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isExpanded = false;
  bool isWishlist = false;

  @override
  void initState() {
    super.initState();
    fetchWishlistState(); // Fetch and initialize isWishlist
  }

  Future<void> fetchWishlistState() async {
    try {
      int userId = await ApiService().getUserId();
      int productId = widget.product['id'] ?? 0;
      bool isProductInWishlist =
          await ApiService().checkIfInWishlist(userId, productId);

      setState(() {
        isWishlist = isProductInWishlist;
      });
    } catch (error) {
      print('Error fetching wishlist state: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name'] ?? 'Product Detail'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImage(widget.product['external_link'] ?? ''),
                  SizedBox(height: 16.0),
                  _buildProductDetails(),
                  SizedBox(height: 16.0),
                  _buildDescription(),
                  SizedBox(height: 16.0),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) => Image.asset(
            'assets/placeholder_image.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    final numberFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.product['name'] ?? '',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isWishlist ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    int userId = await ApiService().getUserId();
                    int productId = widget.product['id'] ?? 0;

                    _handleWishlistButton(userId, productId);
                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              numberFormat.format(widget.product['unit_price'] ?? 0),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi Produk',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            isExpanded
                ? widget.product['description'] ?? 'No description available.'
                : (widget.product['description'] ?? 'No description available.')
                    .substring(0, 100),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.0),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Sembunyikan' : 'Baca Selengkapnya',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton('Beli Langsung', Colors.blue, () {
            // Implement your buy button functionality here
          }, borderRadius: BorderRadius.circular(10.0)),
          _buildButton('+ Keranjang', Colors.green, () async {
            int userId = await ApiService().getUserId();
            int productId = widget.product['id'] ?? 0;
            int wishlistId = widget.product['Wid'] ?? 0;
            double price = (widget.product['unit_price'] ?? 0.0).toDouble();
            String variation =
                "Default"; // Nilai default untuk variabel variation

            await ApiService()
                .addToCart(userId, productId, wishlistId, price, variation);

            // Tampilkan Snackbar saat berhasil menambahkan ke keranjang
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Berhasil Memasukkan Produk Ke Keranjang'),
                duration: Duration(seconds: 1),
              ),
            );
          }, borderRadius: BorderRadius.circular(10.0)),
        ],
      ),
    );
  }

  Widget _buildButton(
    String label,
    Color color,
    VoidCallback onPressed, {
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleWishlistButton(int userId, int productId) async {
    try {
      if (isWishlist) {
        // Remove from wishlist
        await ApiService().deleteWishlistItem(userId, productId);
        // Show Snackbar when successfully removed from the wishlist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product removed from wishlist'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Add to wishlist
        await ApiService().addToWishlist(userId, productId);
        // Show Snackbar when successfully added to the wishlist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added to wishlist'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error handling wishlist: $error');
    }

    setState(() {
      isWishlist = !isWishlist;
    });
  }
}

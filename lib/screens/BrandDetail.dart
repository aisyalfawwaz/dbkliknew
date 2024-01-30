import 'package:dbkliknew/services/ApiServices.dart';
import 'package:dbkliknew/widgets/BuildProductItem.dart';
import 'package:flutter/material.dart';

class BrandDetail extends StatefulWidget {
  final int id;
  final String name;

  BrandDetail({required this.id, required this.name});

  @override
  _BrandDetailState createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  late Future<List<Map<String, dynamic>>> _products;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchProductsForBrand(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No products available for this brand'),
            );
          } else {
            // Filter produk sesuai dengan query pencarian
            final List<Map<String, dynamic>> filteredProducts = _performSearch(
              _searchController.text,
              snapshot.data!,
            );

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.65,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return buildProductItem(context, product);
                },
              ),
            );
          }
        },
      ),
    );
  }

  List<Map<String, dynamic>> _performSearch(
      String query, List<Map<String, dynamic>> products) {
    // Implementasi logika pencarian di sini
    // Misalnya, filter produk berdasarkan query
    return products.where((product) {
      // Sesuaikan logika pencarian sesuai kebutuhan
      return product['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }
}

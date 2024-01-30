import 'package:flutter/material.dart';
import 'package:dbkliknew/services/ApiServices.dart';

class FlashSaleWidget extends StatefulWidget {
  @override
  _FlashSaleWidgetState createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  List<Map<String, dynamic>> flashSaleData = [];

  @override
  void initState() {
    super.initState();
    _fetchFlashSaleData();
  }

  Future<void> _fetchFlashSaleData() async {
    try {
      final data = await ApiService().fetchFlashSaleData();
      setState(() {
        flashSaleData = data;
      });
    } catch (error) {
      print('Error fetching flash sale data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: flashSaleData.map((sale) {
          return _buildFlashSaleCard(sale);
        }).toList(),
      ),
    );
  }

  Widget _buildFlashSaleCard(Map<String, dynamic> sale) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.blue, // Ubah warna card sesuai keinginan
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flash Sale',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ubah warna teks sesuai keinginan
                ),
              ),
              SizedBox(height: 10),
              Text(
                sale['title'] ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ubah warna teks sesuai keinginan
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Start Date: ${_formatDate(sale['start_date'])}',
                style: TextStyle(
                  color: Colors.grey[300], // Ubah warna teks sesuai keinginan
                ),
              ),
              // Add more details or customize based on your API response
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle button click
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // Ubah warna tombol sesuai keinginan
                ),
                child: Text(
                  'Shop Now',
                  style: TextStyle(
                    color:
                        Colors.white, // Ubah warna teks tombol sesuai keinginan
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:dbkliknew/widgets/BuildProductItem.dart';

class SearchDetail extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  // Constructor to receive search results
  SearchDetail({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display search results
            if (searchResults.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    // Check if the index is within the bounds of the list
                    if (index >= 0 && index < searchResults.length) {
                      final product = searchResults[index];
                      return buildProductItem(context, product);
                    } else {
                      // Handle the case where the index is out of bounds
                      return Container(); // or any other placeholder widget
                    }
                  },
                ),
              ),
            // Display message if no results found
            if (searchResults.isEmpty)
              Center(
                child: Text('No results found'),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BrandDetailFilter extends StatefulWidget {
  final Function(String) onFilterChanged;

  BrandDetailFilter({required this.onFilterChanged});

  @override
  _BrandDetailFilterState createState() => _BrandDetailFilterState();
}

class _BrandDetailFilterState extends State<BrandDetailFilter> {
  String _currentFilter = 'none';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFilterButton('Top', 'top'),
          _buildFilterButton('Highest Price', 'high'),
          _buildFilterButton('Lowest Price', 'low'),
          _buildFilterButton('Clear Filter', 'none'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, String filter) {
    return ElevatedButton(
      onPressed: () {
        _onFilterSelected(filter);
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: _currentFilter == filter ? Colors.blue : null,
      ),
    );
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _currentFilter = filter;
    });
    widget.onFilterChanged(filter);
  }
}

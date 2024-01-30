import 'package:flutter/material.dart';

class WarehouseSelectionWidget extends StatefulWidget {
  @override
  _WarehouseSelectionWidgetState createState() =>
      _WarehouseSelectionWidgetState();
}

class _WarehouseSelectionWidgetState extends State<WarehouseSelectionWidget> {
  String selectedLocation = 'Surabaya';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16), // Add left margin
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use Transform to move the text down
                Transform.translate(
                  offset: Offset(0, 14), // Adjust the vertical offset as needed
                  child: Text(
                    'Pilih Warehouse',
                    style: TextStyle(
                      color: Color.fromARGB(221, 51, 50, 50),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add some spacing
                // Dropdown for selecting warehouse location with elevation
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(15),
                  child: DropdownButton<String>(
                    value: selectedLocation,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: <String>['Surabaya', 'Jogja', 'Jakarta']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

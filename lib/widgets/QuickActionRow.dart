import 'package:dbkliknew/utils/MapUtils.dart';
import 'package:dbkliknew/widgets/CameraScan.dart';
import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  String? selectedValCabang = 'surabaya';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickAction(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const CameraScan(),
                ),
              );
            },
            icon: Icons.qr_code_scanner,
            color: Colors.blue,
            label: 'Scan QR',
          ),
          const SizedBox(width: 16),
          _buildQuickAction(
            onTap: () {
              MapUtils.openMap(selectedValCabang!);
            },
            icon: Icons.pin_drop_outlined,
            color: Colors.green,
            label: 'Toko Fisik',
          ),
          const SizedBox(width: 16),
          _buildQuickAction(
            onTap: () {
              // Tambahkan aksi untuk quick action ini
            },
            icon: Icons.shopping_cart,
            color: Colors.orange,
            label: 'Belanja',
          ),
          const SizedBox(width: 16),
          _buildQuickAction(
            onTap: () {
              // Tambahkan aksi untuk quick action ini
            },
            icon: Icons.favorite_border,
            color: Colors.red,
            label: 'Favorit',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

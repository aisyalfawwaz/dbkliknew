import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbkliknew/widgets/AllBrandsSection.dart';
import 'package:dbkliknew/widgets/CarouselSliderWidget.dart';
import 'package:dbkliknew/widgets/FlashSale.dart';
import 'package:dbkliknew/widgets/QuickActionRow.dart';
import 'package:dbkliknew/widgets/TopIconRowWidget.dart';
import 'package:dbkliknew/widgets/WarehouseSelectionWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            TopIconRowWidget(context: context),
            SizedBox(height: 10),
            CarouselSliderWidget(),
            SizedBox(height: 10),
            QuickActionsRow(),
            AllBrandsSection(),
            FlashSaleWidget(),
          ],
        ),
      ),
    );
  }
}

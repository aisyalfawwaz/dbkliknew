import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatefulWidget {
  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  ApiService _apiService = ApiService();
  List<String> _bannerImages = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _fetchBannerData();
  }

  Future<void> _fetchBannerData() async {
    try {
      dynamic data = await _apiService.fetchBannerData();

      if (data != null && data is List) {
        setState(() {
          _bannerImages = List<String>.from(data.map((item) => item['name']));
        });
      } else {
        print('Invalid or null data received from the server');
      }
    } catch (error) {
      print('Error fetching banner data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 400, // Adjust the height as needed
      child: _bannerImages.isNotEmpty
          ? CarouselSlider.builder(
              itemCount: _bannerImages.length,
              itemBuilder: (context, index, realIndex) {
                final imageUrl = _bannerImages[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit
                          .cover, // Menggunakan BoxFit.cover untuk memenuhi kontainer tanpa terpotong
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

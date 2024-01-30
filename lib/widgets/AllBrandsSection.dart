import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbkliknew/screens/BrandDetail.dart';
import 'package:dbkliknew/services/ApiServices.dart';
import 'package:flutter/material.dart';

class AllBrandsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '  Semua Merek',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => const all_brand(),
                //   ),
                // );
              },
              child: const Text(
                'Lihat semua',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: 180,
          child: FutureBuilder(
            future: ApiService().getAllBrand(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading data'),
                );
              }
              List merek = snapshot.data;
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 4,
                ),
                itemCount: merek.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return BrandDetail(
                              id: merek[idx]['id'],
                              name: merek[idx]['name'],
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black38),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://dbklik.co.id/public/${merek[idx]["file_name"]}',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/model/products.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductItem extends StatelessWidget {
  final Products product;

  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF188095), Color(0xFF2AB3C6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  product.image.toString(),
                  fit: BoxFit.fitHeight,
                  height: 600,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  left: 10,
                  child: const Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.04,
                  right: 10,
                  child: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Photo'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.music_note),
                            title: new Text('Music'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.videocam),
                            title: new Text('Video'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.share),
                            title: new Text('Share'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                'Click Me',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

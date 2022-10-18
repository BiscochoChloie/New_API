// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import '../../repositories/product_repository.dart';
import 'single_product_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool isLoading = false;
  int page = 1;
  int last_page = 1;

  @override
  void initState() {
    super.initState();
    ProductRepository().getAllProducts(page);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
        future: ProductRepository().getAllProducts(page),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var product = snapshot.data?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return SingleProductScreen(product: product);
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 135,
                            width: 110,
                            child: Uri.parse(product!.imageLink!).isAbsolute
                                ? Image.network(
                                    product.imageLink!,
                                    fit: BoxFit.cover,
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                        Image.asset(
                                          'assets/images/no-image.png',
                                          height: 135,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25.0),
                                          child: Text(
                                            'No Image Available',
                                          ),
                                        ),
                                      ])

                            //     ),
                            //   );
                            // },

                            ),
                        SizedBox(width: 10),
                        Expanded(
                            child: SizedBox(
                                // width: 500,
                                child: Text(
                          product.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                        SizedBox(width: 40),
                        Text("₱${product.price}")
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5, height: 0.5);
              },
              itemCount: snapshot.data?.length ?? 0);
        });
  }
}

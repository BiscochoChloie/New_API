// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../models/productModel.dart';
import '../../services/product_services.dart';
import 'single_product_screen.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ProductServices.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
        future: ProductServices.getAllProducts(),
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
                          child: Image.network(
                            product!.imageLink!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.amber,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Whoops!',
                                  style: TextStyle(fontSize: 30),
                                ),
                              );
                            },
                          ),
                        ),
                        //                      Image (image: NetworkImageWithRetry(
                        // product!.imageLink!),
                        // errorBuilder: (context, exception, stackTrack) => Icon(Icons.error,),
                        // loadingBuilder: (context, exception, stackTrack) => CircularProgressIndicator(),

                        //                   )),
                        Expanded(
                            child: SizedBox(
                                width: 500,
                                child: Text(
                                  product.name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))),
                        SizedBox(width: 15),
                        Expanded(child: Text("₱${product.price}"))
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

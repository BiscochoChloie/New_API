// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:q/widgets/product_textfield.dart';
import '../../models/productModel.dart';
import '../../services/product_services.dart';
import '../home_screen.dart';
import '../../widgets/button_widget.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool publish = false;
  late int id;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController publishController = TextEditingController();

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want edit this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await ProductServices.editProduct(
                    widget.product.id!,
                    nameController.text,
                    imageLinkController.text,
                    priceController.text);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    id = widget.product.id!;
    nameController.text = widget.product.name!;
    imageLinkController.text = widget.product.imageLink!;
    priceController.text = widget.product.price!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Edit Product",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        ProductTextFormField(
                                            textController: nameController,
                                            label: 'Name')
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Image Link",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        ProductTextFormField(
                                            textController: imageLinkController,
                                            label: 'Image Link')
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        ProductTextFormField(
                                            textController:
                                                descriptionController,
                                            label: 'Description')
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        ProductTextFormField(
                                            textController: priceController,
                                            label: 'price')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ButtonWidget(
                                  text: 'Edit', onClicked: _confirmDialog),
                            ],
                          )
                        ])))));
  }
}

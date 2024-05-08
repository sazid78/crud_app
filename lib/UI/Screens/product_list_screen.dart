import 'dart:convert';

import 'package:crud/UI/Screens/add_new_product_screen.dart';
import 'package:crud/UI/widgets/product_item.dart';
import 'package:crud/data/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool inProgress = false;
  @override
  void initState() {
    getProductList();
    super.initState();
  }

  void getProductList() async {
    productList.clear();
    inProgress = true;
    setState(() {});
    Response response = await get(
      Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData["status"] == "success") {
        for (Map<String, dynamic> productJson in responseData["data"]) {
          productList.add(Product.fromJson(productJson));
        }
      }
    }
    inProgress = false;
    print(productList.length);
    setState(() {});
  }

  void deleteProductList(String productId) async {
    inProgress = true;
    setState(() {});
    Response response = await get(
      Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId"),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      getProductList();
    } else {
      inProgress = false;
      print(productList.length);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          InkWell(
            onTap: () {
              getProductList();
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddNewProductScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: productList[index],
                  onPressDelete: (String productId) {
                    deleteProductList(productId);
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
    );
  }
}

import 'dart:convert';

import 'package:crud/UI/Screens/product_list_screen.dart';
import 'package:crud/data/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key,this.product});

  final Product? product;

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productImageTEcontroller =
      TextEditingController();
  final TextEditingController _productCodeTEcontroller =
      TextEditingController();
  final TextEditingController _productNameTEcontroller =
      TextEditingController();
  final TextEditingController _quantityTEcontroller = TextEditingController();
  final TextEditingController _unitPriceTEcontroller = TextEditingController();
  final TextEditingController _totalPriceTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool addInProgress = false;

  Future<void> addNewProduct() async {
    addInProgress = true;
    setState(() {});
    final Map<String, String> inputMap = {
      "Img": _productImageTEcontroller.text.trim(),
      "ProductCode": _productCodeTEcontroller.text.trim(),
      "ProductName": _productNameTEcontroller.text.trim(),
      "Qty": _quantityTEcontroller.text.trim(),
      "TotalPrice": _totalPriceTEcontroller.text.trim(),
      "UnitPrice": _unitPriceTEcontroller.text.trim()
    };

    final Response response = await post(
        Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputMap));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product has been updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product updated Failed")));
    }
    addInProgress = false;
    setState(() {});
  }
  Future<void> updateProduct() async {
    addInProgress = true;
    setState(() {});
    final Map<String, String> inputMap = {
      "Img": _productImageTEcontroller.text.trim(),
      "ProductCode": _productCodeTEcontroller.text.trim(),
      "ProductName": _productNameTEcontroller.text.trim(),
      "Qty": _quantityTEcontroller.text.trim(),
      "TotalPrice": _totalPriceTEcontroller.text.trim(),
      "UnitPrice": _unitPriceTEcontroller.text.trim()
    };

    final Response response = await post(
        Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(inputMap));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product has been updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product updated Failed")));
    }
    addInProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.product != null){
      _productNameTEcontroller.text = widget.product!.productName;
      _productCodeTEcontroller.text = widget.product!.productCode;
      _quantityTEcontroller.text = widget.product!.quantity;
      _productImageTEcontroller.text = widget.product!.image;
      _unitPriceTEcontroller.text = widget.product!.unitPrice;
      _totalPriceTEcontroller.text = widget.product!.totalPrice;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Product Image";
                    }
                  },
                  controller: _productImageTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Product Image"),
                      hintText: "Enter Product Image"),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Product Code";
                    }
                  },
                  controller: _productCodeTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Product Code"),
                      hintText: "Enter Product Code"),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Product Name";
                    }
                  },
                  controller: _productNameTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Product Name"),
                      hintText: "Enter Product Name"),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Product Quantity";
                    }
                  },
                  controller: _quantityTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Quantity"),
                      hintText: "Enter Product Quantity"),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Unit Price";
                    }
                  },
                  controller: _unitPriceTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Price"), hintText: "Enter Product Price"),
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value?.trim().isNotEmpty ?? false) {
                      return null;
                    } else {
                      return "Enter Total Price";
                    }
                  },
                  controller: _totalPriceTEcontroller,
                  decoration: const InputDecoration(
                      label: Text("Total Price"),
                      hintText: "Enter Total Price"),
                ),
               const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: addInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if(widget.product == null){
                                addNewProduct();
                              }else{
                                updateProduct();
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         const ProductListScreen()));
                            }
                          },
                          child: widget.product != null ? const Text("Update") : const Text("Add")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unitPriceTEcontroller.dispose();
    _totalPriceTEcontroller.dispose();
    _productNameTEcontroller.dispose();
    _quantityTEcontroller.dispose();
    _productCodeTEcontroller.dispose();
    _productImageTEcontroller.dispose();
  }
}

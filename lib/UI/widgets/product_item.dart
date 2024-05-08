import 'package:crud/UI/Screens/add_new_product_screen.dart';
import 'package:crud/UI/Screens/product_list_screen.dart';
import 'package:crud/data/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product, required this.onPressDelete,
  });

  final Product product;
  final Function(String) onPressDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Select Action"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewProductScreen(product: product,)));
                          },
                          child: const Text("Edit"),
                        ),
                        Divider(
                          height: 0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onPressDelete(product.id);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );
                });
          },
          leading: Image.network(product.image),
          title: Text(product.productName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quantity: ${product.quantity}"),
              Text("Total Price : ${product.totalPrice}")
            ],
          ),
          trailing: Text("\$${product.unitPrice}"),
        ),
      ),
    );
  }
}

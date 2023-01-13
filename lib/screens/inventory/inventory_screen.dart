import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/src/streamed_request.dart';
import 'package:teklifyap_mobil2/layout/custom_app_bar.dart';
import 'package:teklifyap_mobil2/layout/custom_text_field.dart';
import 'package:teklifyap_mobil2/screens/inventory/inventory_controller.dart';
import 'package:teklifyap_mobil2/style/colors.dart';

import '../../enums/bottom_app_bar_type.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../models/item_model.dart';
import '../../models/short_item_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryController _controller = Get.put(InventoryController());
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Inventory"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.inventory),
      body: FutureBuilder(
        future: _controller.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var items = snapshot.data as List<ShortItem>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  enabled: !isClicked,
                  onTap: () {
                    toggleClicked();
                    _controller.getDetailed(items[index].id).then((value) {
                      _showPopup(value);
                    }).catchError((error) {
                      Get.snackbar('Error', error.toString(),
                          backgroundColor: ThemeColors.error);
                    });
                  },
                  title: Card(
                    color: ThemeColors.secondaryColor,
                    child: ListTile(
                      title: Text(items[index].name),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _showPopup(Item item) async {
    toggleClicked();
    TextEditingController valueController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    valueController.text = item.value.toString();
    unitController.text = item.unit;

    await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(item.name),
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  placeholder: "Value",
                  controller: valueController,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  placeholder: "Unit",
                  enabled: false,
                  controller: unitController,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      _controller.updateItem(
                          item.id, valueController.text);
                    },
                    child: const Text('Save',
                        style: TextStyle(color: Colors.blue)),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  void toggleClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}

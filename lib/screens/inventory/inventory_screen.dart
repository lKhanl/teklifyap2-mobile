import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late List<ShortItem> items;

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
            items = snapshot.data as List<ShortItem>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  enabled: !isClicked,
                  onTap: () {
                    toggleClicked();
                    _showPopup(items[index].id);
                  },
                  title: Card(
                    color: ThemeColors.secondaryColor,
                    child: ListTile(
                      title: Text(items[index].name),
                      subtitle: Text(items[index].id.toString()),
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

  Future<void> _showPopup(int id) async {
    toggleClicked();
    TextEditingController valueController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: _controller.getDetailed(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Item item = snapshot.data as Item;
                valueController.text = item.value;
                unitController.text = item.unit;
                return SimpleDialog(
                  title: Text(item.name),
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      child: CustomTextField(
                        placeholder: "Value",
                        controller: valueController,
                        isNumber: true,
                        onChange: (value) {
                          item.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
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
                            // deleteItem(index);
                            setState(() {
                              _controller.deleteItem(id);
                              for (var element in items) {
                                if (element.id == id) {
                                  items.remove(element);
                                  break;
                                }
                              }
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            _controller.updateItem(
                                item.id, valueController.text);
                            Navigator.pop(context);
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      _controller.deleteItem(items[index].id);
    });
  }

  void toggleClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: CustomAppBar(
        title: "Inventory",
        actions: [
          // info icon button
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.black,
            onPressed: () {
              _showInfoPopup();
            },
          ),
        ],
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPopup();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
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
                      width: MediaQuery.of(context).size.width * 0.9,
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

  Future<void> _showInfoPopup() async {
    toggleClicked();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Inventory'),
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                  "Inventory is a list of items that you can use to build something."
                  " You can add items to your inventory by tapping floating button on the bottom right."
                  " You can also delete and update items from your inventory by clicking on the item"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      const Text('Close', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddPopup() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    TextEditingController unitController = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add new item'),
          children: <Widget>[
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: unitController,
                      decoration: const InputDecoration(
                        hintText: "Unit",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: valueController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                          hintText: "Value",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    _controller.addItem(
                      nameController.text,
                      unitController.text,
                      valueController.text,
                    );
                    setState(() {
                      _controller.get().then((value) => items);
                    });
                    Navigator.pop(context);
                  },
                  child:
                      const Text('Save', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

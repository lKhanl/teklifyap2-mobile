import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/layout/custom_button.dart';
import 'package:teklifyap_mobil2/layout/custom_text_field.dart';
import 'package:teklifyap_mobil2/screens/inventory/inventory_controller.dart';

import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../models/make_offer.dart';
import '../../models/make_offer_item.dart';
import '../../models/short_item_model.dart';
import '../../style/colors.dart';
import 'make_offer_controller.dart';

class MakeOfferScreen extends StatefulWidget {
  const MakeOfferScreen({super.key});

  @override
  State<MakeOfferScreen> createState() => _MakeOfferScreenState();
}

class _MakeOfferScreenState extends State<MakeOfferScreen> {
  final MakeOfferController _controller = Get.put(MakeOfferController());
  final InventoryController _invController = Get.put(InventoryController());

  TextEditingController titleController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController profitController = TextEditingController();

  Set<MakeOfferItem> offerItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.background,
      appBar: const CustomAppBar(title: "Make Offer"),
      bottomNavigationBar:
          const CustomBottomAppBar(from: BottomAppBarType.profile),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              placeholder: 'Title',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: receiverController,
              placeholder: 'Receiver',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: usernameController,
              placeholder: 'Username',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: profitController,
              placeholder: 'Profit',
            ),
            const SizedBox(height: 16),
            _buildSelectedItems(),
            const SizedBox(height: 16),
            CustomButton(
              backgroundColor: ThemeColors.secondaryColor,
              onPressed: () {
                _showPopUp();
              },
              title: 'Add Item',
            ),
            CustomButton(
              title: 'Make Offer',
              onPressed: () {
                if (titleController.text == '' ||
                    receiverController.text == '' ||
                    usernameController.text == '' ||
                    profitController.text == '') {
                  Get.snackbar('Error', 'Please fill all fields',
                      backgroundColor: ThemeColors.error);
                } else {
                  _controller.makeOffer(
                    offerItems.toList(),
                    MakeOffer(
                      title: titleController.text,
                      receiverName: receiverController.text,
                      userName: usernameController.text,
                      profitRate: int.parse(profitController.text),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // show pop up
  void _showPopUp() {
    Get.defaultDialog(
      title: "Inventory",
      titlePadding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Close", style: TextStyle(color: Colors.red))),
      content: SizedBox(
        height: MediaQuery.of(context).size.height < 500 ? 300 : 500,
        width: MediaQuery.of(context).size.width * 0.9,
        child: FutureBuilder(
          future: _invController.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data as List<ShortItem>;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Card(
                      color: _getColor(items[index].id),
                      child: ListTile(
                        title: Text(items[index].name),
                        trailing: Text(items[index].value.toString()),
                      ),
                    ),
                    onTap: () {
                      if (offerItems
                          .any((element) => element.id == items[index].id)) {
                        Get.snackbar("Error", "Item already added",
                            backgroundColor: ThemeColors.error,
                            colorText: Colors.white);
                      } else {
                        _showAddItemPopUp(items[index]);
                      }
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: CircularProgressIndicator(
              color: ThemeColors.secondaryColor,
            ));
          },
        ),
      ),
    );
  }

  void _showAddItemPopUp(ShortItem item) {
    TextEditingController quantityController = TextEditingController();

    Get.defaultDialog(
      title: "Add Item",
      titlePadding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      barrierDismissible: true,
      content: SizedBox(
        height: 250,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.name),
            const SizedBox(height: 16),
            CustomTextField(
              controller: TextEditingController(text: item.value.toString()),
              placeholder: "Value",
              enabled: false,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: quantityController,
              placeholder: 'Quantity',
              isNumber: true,
            ),
            const SizedBox(height: 16),
            CustomButton(
              backgroundColor: ThemeColors.secondaryColor,
              onPressed: () {
                if (offerItems.any((element) => element.id == item.id)) {
                  Get.snackbar("Error", "Item already added");
                } else {
                  setState(() {
                    offerItems.add(MakeOfferItem(
                        id: item.id,
                        name: item.name,
                        value: double.parse(item.value.toString()),
                        quantity: int.parse(quantityController.text)));
                  });
                  Get.back();
                }
              },
              title: 'Add Item',
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(int id) {
    if (offerItems.any((element) => element.id == id)) {
      return ThemeColors.secondaryColor;
    } else {
      return ThemeColors.background;
    }
  }

  Widget _buildSelectedItems() {
    if (offerItems.isEmpty) {
      return const Text("No item selected");
    } else if (offerItems.length == 1) {
      return Card(
        color: ThemeColors.secondaryColor,
        child: ListTile(
          title: Text(offerItems.elementAt(0).name.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(offerItems.elementAt(0).quantity.toString()),
              const SizedBox(width: 16),
              Text(offerItems.elementAt(0).value.toString()),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    offerItems.remove(offerItems.elementAt(0));
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: offerItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Card(
              color: ThemeColors.secondaryColor,
              child: ListTile(
                title: Text(offerItems.elementAt(index).name.toString()),
                trailing: Text(offerItems.elementAt(index).quantity.toString()),
              ),
            ),
          );
        },
      );
    }
  }
}

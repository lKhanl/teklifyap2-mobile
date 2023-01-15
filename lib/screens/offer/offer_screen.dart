import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teklifyap_mobil2/enums/bottom_app_bar_type.dart';
import 'package:teklifyap_mobil2/layout/custom_loader.dart';
import 'package:teklifyap_mobil2/models/short_offer.dart';
import 'package:teklifyap_mobil2/screens/offer/offer_controller.dart';
import '../../layout/custom_app_bar.dart';
import '../../layout/custom_bottom_app_bar.dart';
import '../../layout/custom_text_field.dart';
import '../../models/offer_model.dart';
import '../../models/short_item_model.dart';
import '../../style/colors.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final OfferController _controller = Get.put(OfferController());
  bool isClicked = false;
  late List<ShortOffer> offers;

  CustomAppBar _buildCustomAppBar() {
    return CustomAppBar(
      title: "Offers",
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          color: Colors.black,
          onPressed: () {
            _showInfoPopup();
          },
        ),
      ],
    );
  }

  CustomBottomAppBar _buildCustomBottomAppBar() {
    return const CustomBottomAppBar(from: BottomAppBarType.offers);
  }

  Widget _buildBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _header(),
          _content(),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width * 0.92,
      height: 50,
      child: Card(
        color: Colors.grey,
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Offer Name"),
              Text("Offer Status"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return FutureBuilder(
      future: _controller.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          offers = snapshot.data as List<ShortOffer>;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return ListTile(
                enabled: !isClicked,
                onTap: () {
                  toggleClicked();
                  _showPopup(offers[index].id);
                },
                title: Card(
                  color: ThemeColors.secondaryColor,
                  child: ListTile(
                    title: Text(offers[index].title),
                    trailing: Switch(
                      value: offers[index].status,
                      onChanged: (bool value) {
                        _controller.changeOfferStatus(offers[index].id);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CustomLoader();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      bottomNavigationBar: _buildCustomBottomAppBar(),
      body: _buildBody(),
    );
  }

  Future<void> _showPopup(int id) async {
    toggleClicked();

    TextEditingController titleController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController receiverNameController = TextEditingController();
    TextEditingController profitRateController = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: _controller.getDetailed(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Offer offer = snapshot.data as Offer;
                titleController.text = offer.title;
                userNameController.text = offer.userName;
                receiverNameController.text = offer.receiverName;
                profitRateController.text = offer.profitRate.toString();

                return SimpleDialog(
                  title: Text(offer.title),
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextField(
                        placeholder: "Title",
                        controller: titleController,
                        onChange: (value) {
                          offer.title = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextField(
                        placeholder: "User Name",
                        controller: userNameController,
                        onChange: (value) {
                          offer.userName = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextField(
                        placeholder: "Receiver Name",
                        controller: receiverNameController,
                        onChange: (value) {
                          offer.receiverName = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextField(
                        placeholder: "Profit Rate",
                        controller: profitRateController,
                        isNumber: true,
                        onChange: (value) {
                          offer.profitRate = double.parse(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          child: const Text(
                            'Click to see items',
                          ),
                          onPressed: () => _showItems(offer.items)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            setState(() {
                              _controller.deleteOffer(id);
                              for (var element in offers) {
                                if (element.id == id) {
                                  offers.remove(element);
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
                            _controller.updateOffer(
                                offer.id,
                                titleController.text,
                                false,
                                userNameController.text,
                                receiverNameController.text,
                                double.parse(profitRateController.text));
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

  void _showItems(List<ShortItem> items) {
    Get.defaultDialog(
      title: "Items",
      barrierDismissible: true,
      content: Container(
        height: 300,
        width: 300,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (!items.isEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      items[index].name,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                  child: Text("There is no items in the offer"));
            }
          },
        ),
      ),
    );
  }

  Future<void> _showInfoPopup() async {
    toggleClicked();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Offers'),
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text("Offers is a page that you can create offers."),
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

  void toggleClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }
}

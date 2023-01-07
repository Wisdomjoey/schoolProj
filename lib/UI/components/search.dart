import 'package:GOCart/CONSTANTS/constants.dart';
import 'package:GOCart/UI/routes/route_helper.dart';
import 'package:GOCart/UI/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      splashRadius: 24,
      tooltip: 'Search',
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => _MySearchDelegate())));
      },
    );
  }
}

class _MySearchDelegate extends StatefulWidget {
  @override
  State<_MySearchDelegate> createState() => _MySearchDelegateState();
}

class _MySearchDelegateState extends State<_MySearchDelegate> {
  late TextEditingController textEditingController;

  List<String> suggestions = [];

  @override
  void initState() {
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.sizedBoxWidth10,
                  right: Dimensions.sizedBoxWidth10,
                  top: Dimensions.sizedBoxWidth10),
              child: Material(
                color: Constants.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.sizedBoxWidth10 / 2)),
                elevation: 5,
                child: InkWell(
                  child: Ink(
                    width: double.maxFinite,
                    height: Dimensions.sizedBoxHeight10 * 5.5,
                    decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(
                            Dimensions.sizedBoxWidth10 / 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: (() => Navigator.pop(context)),
                            splashRadius: 30,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Constants.grey,
                            )),
                        Expanded(
                          child: TextFormField(
                            controller: textEditingController,
                            onChanged: (value) {
                              setState(() {
                                suggestions.clear();
                              });

                              if (value != '') {
                                for (var element in Constants.suggestions) {
                                  if (element.toLowerCase().contains(value)) {
                                    setState(() {
                                      suggestions.add(element);
                                    });
                                  }
                                }
                              }
                            },
                            onEditingComplete: (() {
                              if (textEditingController.text != '') {
                                Get.toNamed(RouteHelper.getProductListPage(), arguments: textEditingController.text);
                              }
                            }),
                            autofocus: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                        IconButton(
                            onPressed: (() {
                              textEditingController.clear();
                            }),
                            splashRadius: 30,
                            icon: const Icon(
                              Icons.close,
                              color: Constants.grey,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.sizedBoxWidth10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: suggestions.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getProductListPage(), arguments: e);
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 2,
                              width: double.maxFinite,
                            ),
                            Text(e),
                            SizedBox(
                              height: Dimensions.sizedBoxHeight10 / 2,
                              width: double.maxFinite,
                            ),
                            const Divider(
                              color: Constants.grey,
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

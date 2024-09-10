import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/add/add_model.dart';
import 'package:my_money/src/add/components/action_view.dart';
import 'package:my_money/src/add/add_constant.dart';
import 'package:my_money/src/add/components/calculator_button.dart';
import 'package:my_money/src/components/date_button.dart';
import 'package:my_money/src/components/modal_button.dart';
import 'package:my_money/src/components/modal_title.dart';
import 'package:my_money/src/components/my_column.dart';
import 'package:my_money/src/components/my_row.dart';
import 'package:my_money/src/components/my_vertical_divider.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  static const routeName = '/add';

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  String selectedType = tabBar[1].title;
  String total = "0";

  var date = DateTime.now();
  var time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final selectedTab = tabBar.firstWhere((item) => item.title == selectedType);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionView(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Close',
                      icon: Icons.close,
                    ),
                    ActionView(
                      onPressed: () {},
                      text: 'SAVE',
                      icon: Icons.check,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                MyRow.separated(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  separator: const SizedBox(
                    height: 12,
                    child: VerticalDivider(),
                  ),
                  children: tabBar
                      .map(
                        (item) => Row(
                          children: [
                            Opacity(
                              opacity: selectedType == item.title ? 1 : 0,
                              child: const Icon(Icons.check_circle),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () {
                                selectedType = item.title;
                                setState(() {});
                              },
                              child: Text(item.title),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyRow.separated(
                  separator: const SizedBox(
                    width: 4,
                  ),
                  children: [
                    ...selectedTab.details.map(
                      (item) => Expanded(
                        child: Column(
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () {
                                if (item.detail == 'Account') {
                                  showAccountList();
                                } else if (item.detail == 'Category') {
                                  showCategoryList();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 32,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      item.detail,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add notes',
                  ),
                  minLines: 5,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          total,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 56,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: deleteNumber,
                        icon: const Icon(Icons.backspace),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ...[
                      "+",
                      7,
                      8,
                      9,
                      "-",
                      4,
                      5,
                      6,
                      "x",
                      1,
                      2,
                      3,
                      ":",
                      0,
                      ".",
                      "="
                    ].map(
                      (item) {
                        final isSymbol = item is String;
                        return CalculatorButton(
                          onPressed: () {
                            if (item is int) {
                              addNumber(item);
                            }
                          },
                          highlightColor: isSymbol,
                          text: item.toString(),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                MyRow.separated(
                  separator: const SizedBox(
                    height: 16,
                    child: MyVerticalDivider(),
                  ),
                  children: [
                    DateButton(
                      text: DateFormat("MMM dd, yyyy").format(date),
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                            DateTime.now().year - 10,
                          ),
                          lastDate: DateTime(
                            DateTime.now().year + 10,
                          ),
                        );

                        if (result == null) return;
                        date = result;
                        setState(() {});
                      },
                    ),
                    DateButton(
                      text: time.format(context),
                      onTap: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (result == null) return;
                        time = result;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNumber(int value) {
    total = int.tryParse("$total$value").toString();
    setState(() {});
  }

  void deleteNumber() {
    total = total.substring(0, total.length - 1);
    if (total.isEmpty) {
      total = "0";
    }
    setState(() {});
  }

  void showAccountList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ModalTitle(
              title: "Select an account",
            ),
            MyColumn.separated(
              separator: const Divider(),
              children: [
                ...accountTypeList.map(
                  (item) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              "Rp${item.total}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            ModalButton(
              text: "ADD NEW ACCOUNT",
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  void showCategoryList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalTitle(title: "Select a category"),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              ...categoryList.map((item) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
          ModalButton(
            text: "ADD NEW CATEGORY",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

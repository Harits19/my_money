import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_model.dart';
import 'package:my_money/src/add/components/action_view.dart';
import 'package:my_money/src/components/my_column.dart';
import 'package:my_money/src/components/my_row.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  static const routeName = '/add';

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    final incomeExpenseDetail = [
      AddTypeDetailModel(
        title: "Account",
        detail: "Account",
        icon: Icons.wallet,
      ),
      AddTypeDetailModel(
        title: "Category",
        detail: "Category",
        icon: Icons.label,
      ),
    ];
    final List<AddTypeModel> tabBar = [
      AddTypeModel(
        details: incomeExpenseDetail,
        title: 'INCOME',
      ),
      AddTypeModel(
        details: incomeExpenseDetail,
        title: 'EXPENSE',
      ),
      AddTypeModel(
        details: [
          AddTypeDetailModel(
            title: "From",
            detail: "Account",
            icon: Icons.wallet,
          ),
          AddTypeDetailModel(
            title: "To",
            detail: "Account",
            icon: Icons.wallet,
          )
        ],
        title: 'TRANSFER',
      ),
    ];

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
                  ...List.generate(
                    3,
                    (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 40,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  "Card",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "Rp1000,000.00",
                                style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Add new account"),
                ),
              ),
            ],
          );
        },
      );
    }

    void showCategoryList() {
      final List<CategoryModel> list = [
        CategoryModel(
          name: "Awards",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Coupons",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Grants",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Lottery",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Refunds",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Rental",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Salary",
          icon: Icons.money,
        ),
        CategoryModel(
          name: "Sale",
          icon: Icons.money,
        ),
      ];
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ModalTitle(title: "Select a category"),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ...list.map((item) {
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
            )
          ],
        ),
      );
    }

    final selectedTab = tabBar.firstWhere((item) => item.title == selectedType);
    return Scaffold(
      body: SafeArea(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
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
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
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
            )
          ],
        ),
      ),
    );
  }
}

class ModalTitle extends StatelessWidget {
  const ModalTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

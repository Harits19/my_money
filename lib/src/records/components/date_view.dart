import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/components/width.dart';
import 'package:my_money/src/model/view_mode.dart';
import 'package:my_money/src/records/components/filter_dialog.dart';
import 'package:my_money/src/util/date_util.dart';

class DateView extends StatefulWidget {
  const DateView({super.key});

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  DateTime date = DateTime.now();

  changeDate(bool isNext) {
    final value = isNext ? 1 : -1;

    final newDate = DateTime(date.year, date.month + value, date.day);

    date = newDate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const double size = 32;

    // return const FilterDialog();
    return Row(
      children: [
        Opacity(
          opacity: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              size: size,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  changeDate(true);
                },
                icon: const Icon(
                  Icons.chevron_left,
                  size: size,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                DateUtil.format1(date),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              IconButton(
                onPressed: () {
                  changeDate(false);
                },
                icon: const Icon(
                  Icons.chevron_right,
                  size: size,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            final newViewMode = await FilterDialog.show(context);
            debugPrint(newViewMode.toString());
          },
          icon: const Icon(
            Icons.sort,
            size: size,
          ),
        )
      ],
    );
  }
}

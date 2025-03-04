import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/filter_dialog.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/util/date_util.dart';

class DateView extends StatefulWidget {
  const DateView({super.key});

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {
  @override
  Widget build(BuildContext context) {
    final date = DateState.of(context).date;
    final changeMonth = DateState.of(context).changeMonth;

    const double size = 32;

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
                  changeMonth(false);
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
                  changeMonth(true);
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

import 'package:flutter/material.dart';
import 'package:my_money/src/components/my_auto_complete.dart';
import 'package:my_money/src/components/my_text_field.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  var type = RecordType.expense;

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const MyTextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("Amount"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () {
                      myLog.i("on click select date picker");
                      final now = DateTime.now();
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(now.year - 10),
                        lastDate: now,
                      );
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Date"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyAutoComplete(
                    options: recordState.categories,
                    decoration: const InputDecoration(
                      label: Text("Category"),
                    ),
                    onChanged: (value) {
                      myLog.i("new value $value");
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyAutoComplete(
                    options: recordState.accounts,
                    decoration: const InputDecoration(
                      label: Text("Account"),
                    ),
                    onChanged: (value) {
                      myLog.i("new value $value");
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SegmentedButton<RecordType>(
                    segments: const <ButtonSegment<RecordType>>[
                      ButtonSegment<RecordType>(
                        value: RecordType.expense,
                        label: Text(RecordType.expenseString),
                        icon: Icon(Icons.calendar_view_day),
                      ),
                      ButtonSegment<RecordType>(
                        value: RecordType.income,
                        label: Text(RecordType.incomeString),
                        icon: Icon(Icons.calendar_view_day),
                      ),
                    ],
                    selected: <RecordType>{type},
                    onSelectionChanged: (Set<RecordType> newSelection) {
                      myLog.i("new type ${newSelection.first}");
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyAutoComplete(
                    options: recordState.notes,
                    textInputType: TextInputType.multiline,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      label: Text(
                        "Notes",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: FilledButton(
                onPressed: () {},
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

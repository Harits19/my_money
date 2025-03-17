import 'package:flutter/material.dart';
import 'package:my_money/src/components/my_auto_complete.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/date_util.dart';
import 'package:my_money/src/util/string_util.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();
  late final recordState = RecordState.of(context);

  var time = DateTime.now();
  var type = RecordType.expense;
  num? amount;
  late var category = recordState.categories.lastOrNull;
  late var account = recordState.accounts.lastOrNull;
  String? notes;

  @override
  Widget build(BuildContext context) {
    String? defaultValidator(String? value) {
      if (value.isNullEmpty) {
        return 'Required';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      validator: defaultValidator,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Amount"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () async {
                        myLog.i("on click select date picker");
                        final now = DateTime.now();
                        final resultDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(now.year - 10),
                          lastDate: now,
                        );
                        if (resultDate == null) return;
                        if (!context.mounted) return;

                        final resultTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (resultTime == null) return;

                        time = resultDate.mergeWithTimeOfDay(resultTime);
                        setState(() {});
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(),
                        child: Text(
                          time.toString(),
                          style: TextTheme.of(context).bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyAutoComplete(
                      initialValue: TextEditingValue(
                        text: category ?? '',
                      ),
                      validator: defaultValidator,
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
                      initialValue: TextEditingValue(
                        text: account ?? '',
                      ),
                      validator: defaultValidator,
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
                        final newValue = newSelection.first;
                        type = newValue;
                        setState(() {});
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/components/base_input_view.dart';
import 'package:my_money/src/components/my_auto_complete.dart';
import 'package:my_money/src/components/my_text_field.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/date_util.dart';
import 'package:my_money/src/util/string_util.dart';

class AddView extends StatefulWidget {
  const AddView({
    super.key,
    this.initialValue,
  });

  final RecordModel? initialValue;

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();
  late final recordState = RecordState.of(context);
  late final recordModel = widget.initialValue;

  late var time = recordModel?.time ?? DateTime.now();
  late var type = recordModel?.type ?? RecordType.expense;
  late var amount = recordModel?.amount;
  late var category =
      recordModel?.category ?? recordState.categories.lastOrNull;
  late var account = recordModel?.account ?? recordState.accounts.lastOrNull;
  late var notes = recordModel?.notes;
  late var isUpdateFlow = widget.initialValue != null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BaseInputView(
        title: isUpdateFlow ? "Edit Record" : "Add Record",
        body: [
          MyTextFormField(
            initialValue: amount?.toString(),
            required: true,
            myTextFieldType: MyTextFieldFormat.currency,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
            ),
            onChanged: (value) {
              amount = int.tryParse(value);
              setState(() {});
            },
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
                time.format4(),
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
            required: true,
            options: recordState.categories,
            decoration: const InputDecoration(
              labelText: ("Category"),
            ),
            onChanged: (value) {
              category = value;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 16,
          ),
          MyAutoComplete(
            initialValue: TextEditingValue(
              text: account ?? '',
            ),
            required: true,
            options: recordState.accounts,
            decoration: const InputDecoration(
              labelText: ("Account"),
            ),
            onChanged: (value) {
              account = value;
              setState(() {});
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
            required: true,
            initialValue: TextEditingValue(
              text: notes ?? '',
            ),
            options: recordState.notes,
            textInputType: TextInputType.multiline,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: ("Notes"),
            ),
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
        onSave: () {
          if (!_formKey.currentState!.validate()) {
            return;
          }

          final id = recordModel?.id;

          final newRecord = RecordModel(
            id: id ?? uniqueId(),
            time: time,
            type: type,
            amount: amount!,
            category: category!,
            account: account!,
            notes: notes!,
          );
          if (isUpdateFlow) {
            recordState.updateRecord(newRecord);
          } else {
            recordState.addRecord(newRecord);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyColumn extends Column {
  const MyColumn({super.key});

  MyColumn.separated({
    super.key,
    required Widget separator,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
    required List<Widget> children,
  }) : super(
          children: (() {
            final length = children.length;
            final newChildren = List<List<Widget>>.generate(length, (index) {
              if (index == 0) return [children[index]];
              return [
                separator,
                children[index],
              ];
            }).toList();

            return newChildren.expand((i) => i).toList();
          })(),
        );
}

void asdasd() {
  ListView.separated;
}

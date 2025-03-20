part of 'service.dart';

abstract class SheetModel {
  List<String> toListString();
}

class _MapValueReturn<A, B> {
  final A item1;
  final B item2;

  _MapValueReturn(
    this.item1,
    this.item2,
  );
}

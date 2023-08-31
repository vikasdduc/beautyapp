import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/packages_model/service.dart';

class Cart extends Equatable {
  const Cart({this.items = const <ServicePackage, int>{}});

  final Map<ServicePackage, int> items;

  int getTotalQuantity() {
    int total = 0;
    for (var v in items.entries) {
      total += v.value;
    }
    return total;
  }

  @override
  List<Object> get props => [items];
}

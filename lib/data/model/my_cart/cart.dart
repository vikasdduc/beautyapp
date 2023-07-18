import 'package:equatable/equatable.dart';
import 'package:glamcode/data/model/packages_model/service.dart';

class Cart extends Equatable {
  const Cart({this.items = const <ServicePackage, int>{}});

  final Map<ServicePackage, int> items;

  @override
  List<Object> get props => [items];
}

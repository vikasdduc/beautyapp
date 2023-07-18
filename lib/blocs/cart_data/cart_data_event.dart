part of 'cart_data_bloc.dart';

@immutable
abstract class CartDataEvent extends Equatable {
  const CartDataEvent();
}

class CartDataStarted extends CartDataEvent {
  @override
  List<Object> get props => [];
}

class CartDataUpdate extends CartDataEvent {
  @override
  List<Object> get props => [];
}

class CartDataUpdateWallet extends CartDataEvent {
  @override
  List<Object> get props => [];
}

class CartBookingSlotUpdate extends CartDataEvent {
  const  CartBookingSlotUpdate(this.item);

  final String item;

  @override
  List<Object> get props => [];
}

class CartCouponUpdate extends CartDataEvent {
  const  CartCouponUpdate(this.item);

  final CouponData item;

  @override
  List<Object> get props => [];
}
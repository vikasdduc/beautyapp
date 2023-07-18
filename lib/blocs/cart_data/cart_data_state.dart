part of 'cart_data_bloc.dart';

@immutable
abstract class CartDataState extends Equatable {
  const CartDataState();
}

class CartDataLoading extends CartDataState {
  @override
  List<Object> get props => [];
}

class CartDataLoaded extends CartDataState {
  const CartDataLoaded({this.cartData = const CartData()});

  final CartData cartData;

  @override
  List<Object> get props => [cartData];
}

class CartDataError extends CartDataState {
  @override
  List<Object> get props => [];
}

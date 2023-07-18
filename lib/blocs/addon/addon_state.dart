part of 'addon_bloc.dart';

@immutable
abstract class AddonState extends Equatable {
  const AddonState();
}

class AddonLoading extends AddonState {
  @override
  List<Object> get props => [];
}

class AddonLoaded extends AddonState {
  const AddonLoaded({this.addonList = const []});

  final List<AddonDatum> addonList;

  @override
  List<Object> get props => [addonList];
}

class AddonError extends AddonState {
  @override
  List<Object> get props => [];
}

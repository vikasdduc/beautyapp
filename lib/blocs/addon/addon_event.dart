part of 'addon_bloc.dart';

@immutable
abstract class AddonEvent extends Equatable{
  const AddonEvent();
}

class AddonStarted extends AddonEvent {
  @override
  List<Object> get props => [];
}

class AddonItemAdded extends AddonEvent {
  const AddonItemAdded(this.item);

  final AddonDatum item;

  @override
  List<Object> get props => [item];
}

class AddonItemRemoved extends AddonEvent {
  const AddonItemRemoved(this.item);

  final AddonDatum item;

  @override
  List<Object> get props => [item];
}

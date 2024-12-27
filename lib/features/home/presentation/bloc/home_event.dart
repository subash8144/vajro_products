part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends HomeEvent {
  final int page;
  final bool isInitial;

  const FetchProducts({
    required this.page,
    required this.isInitial,
  });

  @override
  List<Object?> get props => [
    page,
    isInitial,
  ];
}
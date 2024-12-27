import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products/features/home/domain/entities/product_entity.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.isInitial) {
        emit(HomeLoading());
      }
      final result = await repository.getProducts(event.page);
      result.fold(
        (failure) {
          emit(HomeError(message: failure.message));
        },
        (products) {
          emit(
            HomeLoaded(
              products: products["data"],
              completedStatus: products["totalLength"],
            ),
          );
        },
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}

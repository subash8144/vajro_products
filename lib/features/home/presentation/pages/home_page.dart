import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/core/constants/app_constants.dart';
import 'package:products/features/home/data/repositories/product_repository_impl.dart';
import 'package:products/features/home/presentation/bloc/home_bloc.dart';
import 'package:products/features/home/presentation/widgets/product_item_widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(repository: ProductRepositoryImpl()),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    _currentPage = 1;
    context.read<HomeBloc>().add(FetchProducts(page: _currentPage, isInitial: true));
    setState(() {});
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isFabVisible) {
      setState(() {
        _isFabVisible = true;
      });
    } else if (_scrollController.offset <= 100 && _isFabVisible) {
      setState(() {
        _isFabVisible = false;
      });
    }
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
      });
      context.read<HomeBloc>().add(FetchProducts(page: _currentPage, isInitial: false));
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.productsHeader),),
      drawer: const Drawer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 10)).then((value) => _loadInitialData());
              },
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 8.0,
                controller: _scrollController,
                radius: const Radius.circular(10),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: (state.completedStatus == state.products.length) ? state.products.length : state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.products.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ProductItemWidget(product: state.products[index]);
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      )
          : null,
    );
  }
}

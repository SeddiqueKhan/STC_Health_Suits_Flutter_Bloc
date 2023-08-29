

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/app/sharedPrefs/SharedPrefs.dart';
import 'package:stc_health_suits/common/constants.dart';

import '../../domain/GetAllProducts/model/GetAllProductsModel.dart';
import '../ProductDetail/ProductDetailScreen.dart';
import 'bloc/GetAllProductsBloc.dart';
import 'bloc/GetAllProductsEvent.dart';
import 'bloc/GetAllProductsState.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetAllProductsBloc _getAllProductsBloc = GetAllProductsBloc();

  SharedPrefss sharedPrefss = SharedPrefss();

  @override
  void initState() {
    _getAllProductsBloc.add(GetAllProducts());
    sharedPrefss.removeValues(SAVE_PHONE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _getAllProductsBloc,
        child: BlocListener<GetAllProductsBloc, GetAllProductsState>(
          listener: (context, state) {
            if (state is GetAllProductsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<GetAllProductsBloc, GetAllProductsState>(
            builder: (context, state) {
              if (state is GetAllProductsInitial) {
                return _loading();
              } else if (state is GetAllProductsLoading) {
                return _loading();
              } else if (state is GetAllProductsLoaded) {
                return _buildOnComplete(context, state.getAllProductsListModel);
              } else if (state is GetAllProductsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _loading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  _buildOnComplete(
      BuildContext context, GetAllProductsModel getAllProductsModel) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: const Text('Shop Now', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search for something',
                        prefixIcon: Icon(Icons.search),
                        ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(childCount: getAllProductsModel.products?.length,(context, index) {
            var product = getAllProductsModel.products?[index];
            return _card(product);
          }))
        ],
      ),
    );
  }

  _card(Products? product) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                '${product?.images![0]}',
                height: MediaQuery.of(context).size.width * (3 / 4),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Text(
              '${product?.title}',
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(id: product?.id ?? 0)));
        debugPrint("clicked");
      },
    );
  }
}

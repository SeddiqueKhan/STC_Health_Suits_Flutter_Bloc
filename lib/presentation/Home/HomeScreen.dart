import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/GetAllProductsModel.dart';
import 'package:stc_health_suits/presentation/Home/bloc/GetAllProductsBloc.dart';
import 'package:stc_health_suits/presentation/Home/bloc/GetAllProductsEvent.dart';

import 'bloc/GetAllProductsState.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GetAllProductsBloc _getAllProductsBloc = GetAllProductsBloc();

  @override
  void initState() {
    _getAllProductsBloc.add(GetAllProducts());
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

   _buildOnComplete(BuildContext context, GetAllProductsListModel getAllProductsListModel) {
    return Container(
      child: Text(getAllProductsListModel.products[0].description),
    );
   }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stc_health_suits/core/view_state.dart';
import 'package:stc_health_suits/domain/GetAllProducts/usecase/GetAllProductsUseCase.dart';
import 'package:stc_health_suits/presentation/Home/HomeViewModel.dart';

import '../../app/di/injector.dart';
import '../../data/remote/dio/data_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => homeViewModel,
        onViewModelReady: (viewModel){
          viewModel.getAllProducts();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'All Products',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: _buildBody()
          );
        });
  }

  _buildBody() {
    switch(homeViewModel.viewState.state){
      case (ResponseState.LOADING):
        return Container();
      case (ResponseState.COMPLETE):
        return Container(
          child: Text(''),
        );
      case (ResponseState.EMPTY):
        return Container();
      case (ResponseState.ERROR):
        return Container();
    }
  }
}

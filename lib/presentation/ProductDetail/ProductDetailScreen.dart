import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:stc_health_suits/core/view_state.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';
import 'package:stc_health_suits/presentation/ProductDetail/ProductDetailViewModel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel productDetailViewModel = ProductDetailViewModel();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
        viewModelBuilder: () => productDetailViewModel,
        onViewModelReady: (viewModel) {
          viewModel.getProductDetails();
        },
        builder: (context, viewModel, child) {
          return _buildBody(viewModel, context);
        });
  }

  Widget _buildBody(ProductDetailViewModel viewModel, BuildContext context) {
    switch (viewModel.viewState.state) {
      case (ResponseState.LOADING):
        return Scaffold(
          body: Center(
            child: CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              center: const Text("Loading"),
              progressColor: Colors.blue,
            ),
          ),
        );
      case (ResponseState.COMPLETE):
        return _buildOnComplete(viewModel.viewState.data);
      case (ResponseState.EMPTY):
        return Container();
      case (ResponseState.ERROR):
        return Container();
    }
  }

  _buildOnComplete(ProductDetailsModel? data) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(
                    '${data?.image}', // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      // <-- Icon
                      Icons.arrow_back,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(''),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      // <-- Icon
                      Icons.menu,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text(''),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      "${data?.price} AED",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Center(
              child: ExpansionTile(
                  title: Text(''),
              children: [
                Row()
              ],),
            )
          ],
        ),
      ),
    );
  }
}

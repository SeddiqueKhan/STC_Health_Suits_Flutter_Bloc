import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:stc_health_suits/core/view_state.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';
import 'package:stc_health_suits/presentation/Home/HomeScreen.dart';
import 'package:stc_health_suits/presentation/ProductDetail/ProductDetailViewModel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel productDetailViewModel = ProductDetailViewModel();

  bool isExpanded = false;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.grey,
                child: Stack(
                  children: [
                    Image.network(
                      '${data?.image}',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 20, // adjust the top position as needed
                      left: 20, // adjust the left position as needed
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                        ),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        label: Text(''),
                      ),
                    ),
                    Positioned(
                      top: 20, // adjust the top position as needed
                      right: 20, // adjust the right position as needed
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Background color
                        ),
                        icon: const Icon(Icons.menu, color: Colors.black),
                        label: const Text(''),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 20,
                        child: Text(
                          "${data?.price} AED",
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: IconButton(
                          onPressed: () {
                            if (isExpanded == true) {
                              setState(() {
                                isExpanded = false;
                              });
                            } else {
                              setState(() {
                                isExpanded = true;
                              });
                            }
                          },
                          icon: isExpanded
                              ? const Icon(Icons.keyboard_arrow_down)
                              : const Icon(Icons.keyboard_arrow_up)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${data?.description}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Visibility(
                      visible: isExpanded,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.grey.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Reviews (${data?.rating?.count})",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${data?.rating?.rate}",
                                  style: const TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

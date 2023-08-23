import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health_suits/domain/GetAllProducts/model/ProductDetailsModel.dart';
import 'package:stc_health_suits/presentation/ProductDetail/bloc/ProductDetailsEvent.dart';
import 'package:stc_health_suits/presentation/ProductDetail/bloc/ProductDetailsState.dart';

import 'bloc/ProductDetailsBloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductDetailsBloc _productDetailsBloc = ProductDetailsBloc();

  bool isExpanded = false;

  @override
  void initState() {
    _productDetailsBloc.add(GetProductDetails(id: widget.id));
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
        create: (_) => _productDetailsBloc,
        child: BlocListener<ProductDetailsBloc, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductDetailsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsInitial) {
                return _loading();
              } else if (state is ProductDetailsLoading) {
                return _loading();
              } else if (state is ProductDetailsLoaded) {
                return _buildOnComplete(context, state.productDetailsModel);
              } else if (state is ProductDetailsError) {
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

  _buildOnComplete(BuildContext context, ProductDetailsModel productDetailsModel) {
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
                      '${productDetailsModel.images![0]}',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 20, // adjust the top position as needed
                      left: 20, // adjust the left position as needed
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                    // Positioned(
                    //   top: 20, // adjust the top position as needed
                    //   right: 20, // adjust the right position as needed
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.white, // Background color
                    //     ),
                    //     icon: const Icon(Icons.menu, color: Colors.black),
                    //     label: const Text(''),
                    //   ),
                    // ),
                    Positioned(
                        bottom: 10,
                        left: 20,
                        child: Text(
                          "${productDetailsModel?.price} AED",
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
                        "${productDetailsModel?.description}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Visibility(
                      visible: isExpanded,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.grey.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Reviews (${productDetailsModel?.rating})",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Stock available (${productDetailsModel?.stock})",
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
}

import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/model/response/product_response.dart';
import 'package:phanam/data/remote/request/order_request.dart';
import 'package:phanam/data/remote/request/product_request.dart';
import 'package:phanam/data/repository/order_repository.dart';
import 'package:phanam/data/repository/product_repository.dart';
import 'package:phanam/presentation/features/product/bloc/order/order_bloc.dart';
import 'package:phanam/presentation/features/product/bloc/order/order_event.dart';
import 'package:phanam/presentation/features/product/bloc/order/order_state.dart';
import 'package:phanam/presentation/features/product/bloc/product/product_bloc.dart';
import 'package:phanam/presentation/features/product/bloc/product/product_event.dart';
import 'package:phanam/presentation/features/product/bloc/product/product_state.dart';
import 'package:phanam/presentation/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ProductRequest()),
        Provider(create: (context) => OrderRequest()),
        ProxyProvider<ProductRequest, ProductRepository>(
          create: (context) => ProductRepository(),
          update: (context, request, repository) {
            repository!.updateProductRequest(request: request);
            return repository;
          },
        ),
        ProxyProvider<OrderRequest, OrderRepository>(
          create: (context) => OrderRepository(),
          update: (context, request, repository) {
            repository!.updateOrderRequest(request: request);
            return repository;
          },
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => OrderBloc(orderRepository: context.read())),
          BlocProvider(
              create: (context) =>
                  ProductBloc(productRepository: context.read())),
        ],
        child: const ProductContainer(),
      ),
    );
  }
}

class ProductContainer extends StatefulWidget {
  const ProductContainer({Key? key}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  late ProductBloc _productBloc;
  late OrderBloc _orderBloc;

  //final _quantityController = TextEditingController();
  StreamController<bool> isLoading = StreamController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productBloc = context.read<ProductBloc>();
    _orderBloc = context.read<OrderBloc>();
    isLoading.sink.add(true);
    _productBloc.add(FetchListProduct());
    _orderBloc.add(FetchOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm"),
        actions: [
          BlocConsumer<OrderBloc, OrderStateBase>(
            listener: (context, state) {
              if (state is AddOrderSuccess ||
                  state is AddOrderSuccess ||
                  state is FetchOrderSuccess ||
                  state is FetchOrderFail) {
                isLoading.sink.add(false);
              }
            },
            builder: (context, state) {
              if (state is AddOrderSuccess || state is FetchOrderSuccess) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppConstant.cartRouteName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, top: 10),
                    child: Badge(
                      badgeContent:
                          Text(state.orderResponse!.totalQuantity.toString()),
                      // badgeContent: Text(state.orderResponse!.carts!
                      //     .map((element) => element.quantity)
                      //     .reduce(
                      //   (value, element) {
                      //     return value! + element!;
                      //   },
                      // ).toString()),
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                child: const Icon(Icons.shopping_cart_outlined),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductStateBase>(
        listener: (context, state) {
          if (state is FetchProductsSuccess || state is FetchProductsError) {
            isLoading.sink.add(false);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is FetchProductsSuccess)
                ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return _buildItemAddProduct(state.list[index]);
                    }),
              if (state is FetchProductsError)
                Center(
                  child: Text(state.message.toString()),
                ),
              StreamBuilder<bool>(
                stream: isLoading.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return const LoadingWidget();
                  }
                  return const SizedBox();
                },
                initialData: false,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemAddProduct(ProductResponse response) {
    return SizedBox(
      height: 125,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                    AppConstant.imgPath +
                        AppConstant.productRouteName +
                        "/" +
                        response.productImage!,
                    width: 110,
                    fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(response.productName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "" +
                              NumberFormat("#,###", "en_US")
                                  .format(response.productPrice) +
                              " đ",
                          style: const TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {
                          String? idProduct = response.idProduct.toString();
                          String? quantity = response.quantity.toString();
                          String? checked = response.checked.toString();
                          String? type = response.type.toString();
                          isLoading.sink.add(true);
                          _orderBloc.add(AddOrder(
                              idProduct: idProduct,
                              quantity: quantity,
                              checked: checked,
                              type: type));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(50, 0, 207, 208);
                              } else {
                                return const Color.fromARGB(250, 0, 207, 208);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            )))),
                        child: const Text("Thêm vào giỏ",
                            style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

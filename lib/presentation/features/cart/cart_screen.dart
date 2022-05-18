import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/model/response/product_response.dart';
import 'package:phanam/data/remote/request/quantity_request.dart';
import 'package:phanam/data/repository/cart_repository.dart';
import 'package:phanam/presentation/features/cart/bloc/cart_bloc.dart';
import 'package:phanam/presentation/features/cart/bloc/cart_event.dart';
import 'package:phanam/presentation/features/cart/bloc/cart_state.dart';
import 'package:phanam/presentation/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => QuantityRequest()),
          ProxyProvider<QuantityRequest, QuantityRepository>(
            create: (context) => QuantityRepository(),
            update: (context, request, repository) {
              repository!.updateQuantityRequest(request: request);
              return repository;
            },
          )
        ],
        child: BlocProvider<CartBloc>(
            create: (context) =>
                CartBloc(quantityRepository: context.read<QuantityRepository>()),
            child: const CartContainer()));
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  late CartBloc _cartBloc;
  //final _quantityController = TextEditingController();
  StreamController<bool> isLoading = StreamController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartBloc = context.read<CartBloc>();
    _cartBloc.add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.status == CartStatus.AddQuantitySuccess) {
            isLoading.sink.add(false);
            Navigator.pushReplacementNamed(
                context, AppConstant.cartRouteName);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state.status == CartStatus.fetchCartSuccess)
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.cartResponse!.carts!.length,
                            itemBuilder: (lstContext, index) =>
                                _buildItem(state.cartResponse!.carts![index])),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.teal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                              "Tổng tiền : " +
                                  NumberFormat("#,###", "en_US").format(
                                      state.cartResponse!.totalAmount) +
                                  " đ",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white))),
                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            child: const Text("Thanh toán",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          )),
                    ],
                  ),
                ),
              if (state.status == CartStatus.loading)
                const Center(child: LoadingWidget())
              else if (state.status == CartStatus.fetchCartFail)
                Center(child: Text(state.message.toString()))
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(ProductResponse productResponse) {
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      AppConstant.imgPath +
                          AppConstant.productRouteName +
                          "/" +
                          productResponse.productImage.toString(),
                      width: 120,
                      fit: BoxFit.fill),
                ),
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
                        child: Text(productResponse.productName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "" +
                              NumberFormat("#,###", "en_US")
                                  .format(productResponse.productPrice) +
                              " đ",
                          style: const TextStyle(fontSize: 12)),
                      Row(
                        children: [
                          _buildButtonRemoveQuantity(productResponse),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(productResponse.quantity.toString(),
                                style: const TextStyle(fontSize: 14)),
                          ),
                          _buildButtonAddQuantity(productResponse),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              _buildButtonRemoveProduct (productResponse),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRemoveQuantity(ProductResponse productResponse) {
    return IconButton(
    icon: const Icon(Icons.remove_circle, color: Colors.teal,),
    onPressed: () {
      if (productResponse.quantity! > 0) {
        String? idProduct = productResponse.idProduct
            .toString();
        String? quantity = (productResponse
            .quantity! - 1).toString();
        String? checked = productResponse.checked
            .toString();
        String? type = "0";
        //isLoading.sink.add(true);
        _cartBloc.add(AddQuantity(
            idProduct: idProduct,
            quantity: quantity,
            checked: checked,
            type: type));
      }
    },
    );
  }

  Widget _buildButtonAddQuantity (ProductResponse productResponse) {
    return IconButton(
      icon: const Icon(Icons.add_circle, color: Colors.teal,),
      onPressed: () {
        if (productResponse.quantity! > 0) {
          String? idProduct = productResponse.idProduct
              .toString();
          String? quantity = (productResponse
              .quantity! + 1).toString();
          String? checked = productResponse.checked
              .toString();
          String? type = "0";
          //isLoading.sink.add(true);
          _cartBloc.add(AddQuantity(
              idProduct: idProduct,
              quantity: quantity,
              checked: checked,
              type: type));
        }
      },
    );
  }

  Widget _buildButtonRemoveProduct (ProductResponse productResponse) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.remove_shopping_cart, color: Colors.teal,),
        onPressed: () {
          if (productResponse.quantity! >= 0) {
            String? idProduct = productResponse.idProduct
                .toString();
            String? quantity = "0";
            String? checked = productResponse.checked
                .toString();
            String? type = "0";
            //isLoading.sink.add(true);
            _cartBloc.add(AddQuantity(
                idProduct: idProduct,
                quantity: quantity,
                checked: checked,
                type: type));
          }
        },
      ),
    );
  }
}

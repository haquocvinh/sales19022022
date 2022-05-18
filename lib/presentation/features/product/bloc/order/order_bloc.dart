import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phanam/data/model/response/order_response.dart';
import 'package:phanam/data/remote/response/app_response.dart';
import 'package:phanam/data/repository/order_repository.dart';
import 'package:phanam/presentation/features/product/bloc/order/order_event.dart';
import 'package:phanam/presentation/features/product/bloc/order/order_state.dart';

class OrderBloc extends Bloc<OrderEventBase, OrderStateBase> {
  late OrderRepository _orderRepository;

  OrderBloc({required OrderRepository orderRepository})
      : super(OrderStateInit()) {
    _orderRepository = orderRepository;

    on<FetchOrder>((event, emit) async {
      try {
        Response response = await _orderRepository.fetchOrder();
        AppResponse<OrderResponse> orderResponse =
            AppResponse.fromJson(response.data, OrderResponse.fromJson);
        emit(FetchOrderSuccess.copyWith(data: orderResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(FetchOrderFail(e.response!.data['message'].toString()));
        } else {
          emit(FetchOrderFail(e.error.toString()));
        }
      } catch (e) {
        emit(FetchOrderFail(e.toString()));
      }
    });

    on<AddOrder>((event, emit) async {
      try {
        Response response = await _orderRepository.addOrder(
            event.idProduct, event.quantity, event.checked, event.type);
        AppResponse<OrderResponse> orderResponse =
            AppResponse.fromJson(response.data, OrderResponse.fromJson);
        emit(AddOrderSuccess.copyWith(data: orderResponse.data));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(AddOrderFail(e.response!.data['message'].toString()));
        } else {
          emit(AddOrderFail(e.error.toString()));
        }
      } catch (e) {
        emit(AddOrderFail(e.toString()));
      }
    });
  }
}

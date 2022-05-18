import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phanam/data/model/response/product_response.dart';
import 'package:phanam/data/remote/response/app_response.dart';
import 'package:phanam/data/repository/product_repository.dart';
import 'package:phanam/presentation/features/product/bloc/product/product_event.dart';
import 'package:phanam/presentation/features/product/bloc/product/product_state.dart';

class ProductBloc extends Bloc<ProductEventBase, ProductStateBase> {
  late ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : super(ProductStateInit()) {
    _productRepository = productRepository;

    on<FetchListProduct>((event, emit) async {
      try {
        Response response = await _productRepository.fetchProducts();
        AppResponse<List<ProductResponse>> list =
            AppResponse.fromJson(response.data, (data) {
          return List<ProductResponse>.from(
              response.data["data"].map((e) => ProductResponse.fromJson(e)));
        });
        emit(FetchProductsSuccess(list: list.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          //print ("Dữ liệu trả về ${e.response}");
          emit(FetchProductsError(e.response!.data['message'].toString()));
        } else {
          emit(FetchProductsError(e.toString()));
        }
      } catch (e) {
        emit(FetchProductsError(e.toString()));
      }
    });
  }
}

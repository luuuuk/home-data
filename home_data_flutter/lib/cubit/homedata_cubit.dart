import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

part 'homedata_state.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  HomeDataCubit() : super(HomeDataState());

  final _api = HomeDataAPI();

  Future<void> getData() async {
    emit(state.copyWith(status: 'loading'));

    try {
      // request data
      Map<String, dynamic> document = {};

      final response = await _api.getData();

      if (response.isNotEmpty) {
        document = {'sensor': response};
      } else {
        throw Exception();
      }

      print('last entry: ' + document['sensor'].last['date'].toString());

      emit(
        state.copyWith(status: 'success', document: document),
      );
    } on Exception {
      emit(state.copyWith(status: 'failure'));
    }
  }
}

class HomeDataAPI {
  static const String basePath = r'http://192.168.2.110:3001';

  Dio dio;

  // final basicAuth = 'Basic ${base64Encode(utf8.encode('go:SwiftTransport'))}';
  // RequestOptions options.headers['Authorization'] = basicAuth;

  HomeDataAPI({Dio? dio, String? basePathOverride})
      : dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: 6000,
              receiveTimeout: 4000,
            ));

  /// getData
  ///
  /// Returns a [Future] containing a [Response] with a [Map<String, dynamic>] as data
  /// Throws [DioError] if API call or serialization fails
  Future<List> getData() async {
    /// Acceept any certificate
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    String requestPath = basePath + '/recentData';
    Response response;
    List resultDocument = [];

    response = await dio.get(
      requestPath,
    );

    try {
      resultDocument = response.data;
    } catch (error, stackTrace) {
      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
        type: DioErrorType.other,
        error: error,
      )..stackTrace = stackTrace;
    }

    return resultDocument;
  }
}

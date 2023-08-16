

import 'package:product_task/data/response/status.dart';

import '../../res/texts.dart';

class ApiResponse<T> {
  Status? status;

  T? data;

  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "${Texts.status} : $status \n"
        " ${Texts.message} : $message \n"
        " ${Texts.data}: $data";
  }
}

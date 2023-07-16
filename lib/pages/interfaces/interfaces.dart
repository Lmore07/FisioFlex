class GeneralResponse<T> {
  final T? data;
  final int? statusCode;
  final String? error;
  final String? message;

  GeneralResponse({this.data, this.message, this.statusCode, this.error});
}


enum HttpError {
  
  /// The request could not be understood or was missing required parameters.
  badRequest(code: 400, message: 'Bad Request'),

  /// The server encountered an unexpected condition that prevented it from
  /// fulfilling the request.
  serverError(code: 500, message: 'Internal Server Error'),

  /// The requested resource could not be found on the server.
  notFound(code: 404, message: 'Error not found'),

  /// The HTTP version used in the request is not supported by the server.
  versionNotSupported(code: 505, message: 'HTTP Version is not supported on this request');

  final String message;
  final int code;

  /// The constructor initializes each error type with its corresponding
  /// status code and message.
  const HttpError({required this.message, required this.code});
}

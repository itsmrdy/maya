///This method ensures that the process is running as 
///asynchronous task
Future<void> ensureAsync() async =>
    await Future.delayed(const Duration(seconds: 0));
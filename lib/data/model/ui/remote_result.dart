abstract class RemoteResult<T> {}

class SuccessRemote<T> extends RemoteResult<T> {
  final T data;

  SuccessRemote(this.data);
}

class ErrorRemote<T> extends RemoteResult<T> {
  final String message;

  ErrorRemote(this.message);
}

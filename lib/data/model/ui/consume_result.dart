abstract class ConsumeResult<T> {}

class SuccessConsume<T> extends ConsumeResult<T> {
  final T data;

  SuccessConsume(this.data);
}

class ErrorConsume<T> extends ConsumeResult<T> {
  final T data;
  final String message;

  ErrorConsume(this.message, this.data);
}

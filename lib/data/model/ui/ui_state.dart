class UIState<T> {
  T data;
  String message;
  bool isLoading;

  UIState({required this.data, this.message = "", this.isLoading = false});

  void updateData(T data, [bool loading = false]) {
    this.data = data;
    isLoading = loading;
  }

  void updateMessage([String newMessage = "", bool loading = false]) {
    message = newMessage;
    isLoading = loading;
  }

  void updateMessageWithData(T data,
      [String newMessage = "", bool loading = false]) {
    this.data = data;
    message = newMessage;
    isLoading = loading;
  }

  void updateLoading([bool loading = false]) {
    isLoading = loading;
  }
}

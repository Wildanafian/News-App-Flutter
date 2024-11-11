class EmptyHeadlineException implements Exception {
  final String message;

  EmptyHeadlineException([this.message = 'Headline news is empty']);

  @override
  String toString() => message;
}

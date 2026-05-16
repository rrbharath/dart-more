abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Object error;
  final StackTrace stackTrace;

  const Failure(this.error, this.stackTrace);
}

Future<List<Result<T>>> allSettled<T>(List<Future<T>> futures) => Future.wait(
    futures.map((future) async {
      try {
        final value = await future;
        return Success<T>(value);
      } catch (error, stackTrace) {
        return Failure<T>(error, stackTrace);
      }
    })
  );
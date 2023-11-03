abstract class IUseCase<T, P> {
  Future<T> call({P params});
}

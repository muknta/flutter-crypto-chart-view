mixin IUseCase<T, P> {
  T execute({required P params});
}

typedef NoParams = void;

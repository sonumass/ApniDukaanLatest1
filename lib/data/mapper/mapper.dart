class MapperFactory {
  static Map<Type, dynamic Function(dynamic)> constructors = {};

  static void registerConstructor<T>(T Function(dynamic) callback) {
    if (constructors[T] == null) constructors[T] = callback;
  }

  static void initialize() {}
}

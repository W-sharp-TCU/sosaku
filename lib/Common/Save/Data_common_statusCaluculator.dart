class StatusCalculator{
  /// Singleton constructor
  static final StatusCalculator _myInstance = StatusCalculator._internalConstructor();
  StatusCalculator._internalConstructor();
  factory StatusCalculator() => _myInstance;
}


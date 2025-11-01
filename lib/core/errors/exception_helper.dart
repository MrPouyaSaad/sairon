import 'package:dartz/dartz.dart';

import 'failures.dart';

T? extractRight<T>(Either<Failure, T> either) =>
    either.fold((l) => null, (r) => r);

Failure? extractLeft<T>(Either<Failure, T> either) =>
    either.fold((l) => l, (r) => null);

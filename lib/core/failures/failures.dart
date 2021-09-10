

import 'package:equatable/equatable.dart';

abstract class Failure{}

class ServerFailure extends Failure with EquatableMixin{
  @override
  List<Object?> get props => [];
}

class InternetFailure extends Failure  {}
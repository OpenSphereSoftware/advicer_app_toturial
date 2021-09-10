import 'package:equatable/equatable.dart';

class AdviceEntity with EquatableMixin {
  final String advice;
  final int id;

  AdviceEntity({required this.advice, required this.id});

  @override
  List<Object?> get props => [advice,id];
}

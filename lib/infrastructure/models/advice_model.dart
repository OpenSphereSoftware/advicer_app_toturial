import 'package:equatable/equatable.dart';

import '../../domain/entities/advice_enitity.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required String advice, required int id})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
        advice: json['advice']!, id: (json['id']! as num).toInt());
  }

  @override
  List<Object?> get props => [advice, id];
}

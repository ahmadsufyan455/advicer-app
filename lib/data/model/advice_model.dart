import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required String advice, required int id})
      : super(advice: advice, id: id);

  factory AdviceModel.fromJson(Map<String, dynamic> json) =>
      AdviceModel(advice: json['advice'], id: json['advice_id']);
}

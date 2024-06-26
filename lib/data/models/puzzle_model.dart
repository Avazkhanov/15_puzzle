import 'package:get_it_example/utils/app_constants.dart';

class PuzzleModel {
  PuzzleModel({required this.count, required this.dateTime, this.id});

  int? id;
  final int count;
  final int dateTime;

  factory PuzzleModel.fromJson(Map<String, dynamic> json) {
    return PuzzleModel(
      id: json["_id"],
      count: json["count"] as int? ?? 0,
      dateTime: json["datetime"] as int? ?? 0,
    );
  }

  PuzzleModel copyWith({
    int? id,
    int? count,
    int? dateTime,
  }) {
    return PuzzleModel(
      id: id ?? this.id,
      count: count ?? this.count,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppConstants.count: count,
      AppConstants.datetime: dateTime,
    };
  }
}

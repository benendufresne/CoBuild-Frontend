import 'package:cobuild/utils/enums/job_enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filters_model.g.dart';

@JsonSerializable()
class FiltersModel {
  FiltersModel(
      {required this.status,
      required this.priority,
      required this.selectedSortBy,
      required this.selectedServiceCategory});

  Map<StatusEnum, bool> status;
  Map<PriorityEnum, bool> priority;
  SortByEnum? selectedSortBy;
  List<String> selectedServiceCategory;

  factory FiltersModel.fromJson(Map<String, dynamic> json) =>
      _$FiltersModelFromJson(json);
  Map<String, dynamic> toJson() => _$FiltersModelToJson(this);

  FiltersModel copyWith({
    Map<StatusEnum, bool>? status,
    Map<PriorityEnum, bool>? priority,
    List<String>? selectedServiceCategory,
    SortByEnum? selectedSortBy,
  }) {
    return FiltersModel(
        status: status != null
            ? Map<StatusEnum, bool>.from(status)
            : Map<StatusEnum, bool>.from(this.status),
        priority: priority != null
            ? Map<PriorityEnum, bool>.from(priority)
            : Map<PriorityEnum, bool>.from(this.priority),
        selectedSortBy: selectedSortBy ?? this.selectedSortBy,
        selectedServiceCategory: selectedServiceCategory != null
            ? List<String>.from(selectedServiceCategory)
            : List<String>.from(this.selectedServiceCategory));
  }
}

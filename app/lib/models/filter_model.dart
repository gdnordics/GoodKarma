import 'package:flutter/material.dart';

class RangeFilter {
  final int min;
  final int max;
  const RangeFilter({
    required this.min,
    required this.max,
  });

  factory RangeFilter.fromValues(RangeValues values) {
    return RangeFilter(min: values.start.round(), max: values.end.round());
  }

  RangeFilter clone() {
    return RangeFilter(min: min, max: max);
  }
}

class FilterModel{
  final RangeFilter durationRange;
  final RangeFilter volunteerRange;
  final Set<String> locations;
  const FilterModel({
    required this.durationRange,
    required this.volunteerRange,
    required this.locations
  });

  FilterModel clone() {
    return FilterModel(
      durationRange: durationRange.clone(),
      volunteerRange: volunteerRange.clone(),
      locations: Set.from(locations)
    );
  }
}
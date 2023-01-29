import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event_locations.dart';
import 'package:good_karma_app/models/filter_model.dart';
import 'package:good_karma_app/screens/search/widgets/multi_select_fields.dart';
import 'package:good_karma_app/screens/search/widgets/toggle_field_item.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';

class SliderLimitModel{
  final double maxValue;
  final double minValue;
  final int slices;
  const SliderLimitModel({
    required this.maxValue,
    required this.minValue,
    required this.slices
  });
}

class FilterLimitsModel{
  final SliderLimitModel durationLimits;
  final SliderLimitModel volunteerLimits;
  final List<Location> locations;
  const FilterLimitsModel({
    required this.durationLimits,
    required this.volunteerLimits,
    required this.locations
  });
}

class SearchFilterModal extends StatefulWidget {
  final Function(FilterModel) onApply;
  final FilterModel defaultValues;
  final FilterModel currentValues;
  final FilterLimitsModel limits;

  const SearchFilterModal({
    Key? key,
    required this.onApply,
    required this.defaultValues,
    required this.currentValues,
    required this.limits
    }) : super(key: key);

  @override
  _SearchFilterModalState createState() => _SearchFilterModalState();
}

class _SearchFilterModalState extends State<SearchFilterModal> {
  late RangeValues currentDurationRange;
  late RangeValues currentVolunteerRange;
  late Set<String> currentLocations;

  @override
  void initState() {
    super.initState();

    currentDurationRange = cloneRange(widget.currentValues.durationRange);
    currentVolunteerRange = cloneRange(widget.currentValues.volunteerRange);
    currentLocations = cloneLocation(widget.currentValues.locations);
  }

  void toggleLocation(String location) {
    var l = cloneLocation(currentLocations);
    if (l.contains(location)) {
      l.remove(location);
    } else {
      l.add(location);
    }
    setState(() {
      currentLocations = l;
    });
  }

  void applyFilter() {
    FilterModel filter = FilterModel(
      durationRange: RangeFilter.fromValues(currentDurationRange), 
      volunteerRange: RangeFilter.fromValues(currentVolunteerRange), 
      locations: currentLocations);
    
    Navigator.of(context).pop();
    widget.onApply(filter);
  }

  void resetFilter() {
    
    debugPrint("resetFilter()");
  }

  RangeValues cloneRange(RangeFilter filter) {
    return RangeValues(
      filter.min.toDouble(),
      filter.max.toDouble()
    );
  }

  Set<String> cloneLocation(Set<String> locations) {
    debugPrint(locations.toString());
    return Set.from(locations);
  }

  Widget buildLocations(BuildContext context) {
    List<ToggleFieldItem> fields = List.empty(growable: true);

    widget.limits.locations.where((l) => currentLocations.contains(l.id)).forEach((l) {
      fields.add(ToggleFieldItem(
          label: l.name,
          value: l.id,
          selected: true,
          onToggle: toggleLocation));
    });

    widget.limits.locations.where((l) => !currentLocations.contains(l.id)).forEach((l) {
      fields.add(ToggleFieldItem(
          label: l.name,
          value: l.id,
          selected: false,
          onToggle: toggleLocation));
    });

    return MultiSelectFields(items: fields);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        alignment: Alignment.topLeft,
                        child: Text("Duration",
                            style: boldTextStyle.copyWith(
                                fontSize: 20.0, color: primaryTextColor))),
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: RangeSlider(
                          values: currentDurationRange,
                          max: widget.limits.durationLimits.maxValue,
                          min: widget.limits.durationLimits.minValue,
                          divisions: widget.limits.durationLimits.slices,
                          activeColor: primaryLightGreenColor,
                          labels: RangeLabels(
                            currentDurationRange.start.round().toString(),
                            currentDurationRange.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              currentDurationRange = RangeValues(values.start, values.end);
                            });
                          },
                        )),
                  ]),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text("Volunteers",
                              style: boldTextStyle.copyWith(
                                  fontSize: 20.0, color: primaryTextColor))),
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: RangeSlider(
                            values: currentVolunteerRange,
                            max: widget.limits.volunteerLimits.maxValue,
                            min: widget.limits.volunteerLimits.minValue,
                            divisions: widget.limits.volunteerLimits.slices,
                            activeColor: primaryLightGreenColor,
                            labels: RangeLabels(
                              currentVolunteerRange.start.round().toString(),
                              currentVolunteerRange.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                currentVolunteerRange = RangeValues(values.start, values.end);
                              });
                            },
                          )),
                    ])),
                SizedBox(height: 10.0),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(children: [
                      Container(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text("Location",
                              style: boldTextStyle.copyWith(
                                  fontSize: 20.0, color: primaryTextColor))),
                      Container(
                        margin: const EdgeInsets.only(top: 10, right: 10),
                        alignment: Alignment.topLeft,
                        height: 200,
                        child: 
                        ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: buildLocations(context),
                      ))),
                    ])),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                            text: "APPLY",
                            width: 200,
                            height: 58,
                            color: primaryLightGreenColor,
                            onPressed: applyFilter),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                currentDurationRange = cloneRange(widget.defaultValues.durationRange);
                                currentVolunteerRange = cloneRange(widget.defaultValues.volunteerRange);
                                currentLocations = cloneLocation(widget.defaultValues.locations);
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Text(
                                "RESET",
                                style: boldTextStyle.copyWith(
                                    color: secondaryTextColor, fontSize: 18.0),
                              ),
                            ))
                      ]),
                )
              ]))),
    );
  }
}

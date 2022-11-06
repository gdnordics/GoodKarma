import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/filter_model.dart';
import 'package:good_karma_app/screens/event_details/event_details_screen.dart';
import 'package:good_karma_app/screens/search/widgets/search_filter_modal.dart';
import 'package:good_karma_app/services/search_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/event_list.dart';
import 'package:good_karma_app/widgets/events_loading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FilterModel defaultFilters = FilterModel(
      durationRange: RangeFilter(min: 0, max: 24),
      volunteerRange: RangeFilter(min: 1, max: 100),
      locations: {"stockholm"});

  final FilterLimitsModel filterLimits = FilterLimitsModel(
      durationLimits: SliderLimitModel(maxValue: 24, minValue: 0, slices: 24),
      volunteerLimits: SliderLimitModel(maxValue: 100, minValue: 1, slices: 99),
      locations: [
        LocationModel(label: "Stockholm", value: "stockholm"),
        LocationModel(label: "Gothenburg", value: "gothenburg"),
        LocationModel(label: "Århus", value: "arhus"),
        LocationModel(label: "Copenhagen", value: "copenhagen"),
      ]);

  late FilterModel filter;
  late String? query;
  Future<List<Event>>? _searchResult;

  Future<List<Event>> getPast(BuildContext context, String? query, FilterModel filter) async {
    var ds = Provider.of<SearchService>(context, listen: false);
    return await ds.searchEvents(query ?? "", filter);
  }

  @override
  initState() {
    super.initState();

    filter = defaultFilters.clone();
    query = null;
    _searchResult = getPast(context, query, filter);
  }

  onApplyFilter(FilterModel newfilters) {
    setState(() {
      filter = newfilters.clone();
      _searchResult = getPast(context, query, filter);
    });
  }

  onShowFilter() {
    showBarModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        )),
        builder: (context) => SearchFilterModal(
              defaultValues: defaultFilters,
              currentValues: filter,
              limits: filterLimits,
              onApply: onApplyFilter,
            ));
  }

  onQueryChange(String value) {
    setState(() {
      query = value;
      _searchResult = getPast(context, query, filter);
    });
  }

  void onGoBack(dynamic _) {
    setState(() {
      _searchResult = getPast(context, query, filter);
    });
  }

  onEventPressed(String eventId) {
    Navigator.of(context)
        .push(SlideRightRoute(
            page: EventDetailsScreen(
          eventId: eventId,
        )))
        .then(onGoBack);
  }

  onClose() {
    Navigator.of(context).pop();
  }

  Widget buildEvents(BuildContext context, List<Event> events) {
    return EventList(events: events, onEventPressed: onEventPressed);
  }

  @override
  Widget build(BuildContext context) {
    var outlineBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8.0),
    );

    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundColor,
            body: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                alignment: Alignment.centerRight,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            Icon(Icons.close, size: 32.0, color: secondaryTextColor)),
                    onTap: onClose),
              ),
              SizedBox(height: 15.0),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text("Search for events",
                      style: normalKarmaTextStyle.copyWith(
                          fontSize: 32.0, 
                          color: primaryColor))),
              SizedBox(height: 30.0),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 20.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kEditTextBorderColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 300,
                  child: Theme(
                   child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.5),
                      hintText: "Search...",
                      hintStyle: normalTextStyle.copyWith(
                          fontSize: 16.0, color: kEditTextHintColor),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 10.0, top: 10.0),
                      focusedBorder: outlineBorder,
                      enabledBorder: outlineBorder,
                      errorBorder: outlineBorder,
                      disabledBorder: outlineBorder,
                      focusedErrorBorder: outlineBorder,
                      focusColor: primaryColor,
                      prefixIcon: Icon(Icons.search_outlined),
                      
                    ),
                    onSubmitted: onQueryChange,
                  ),
                  data: Theme.of(context).copyWith(primaryColor: primaryColor))
                ),
                SizedBox(width: 10.0),
                Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: primaryColor),
                    child: IconButton(
                      icon: Icon(Icons.tune, size: 28.0),
                      color: backgroundColor,
                      onPressed: onShowFilter,
                    )),
                SizedBox(width: 10.0),
              ]),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: FutureBuilder(
                      future: _searchResult,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch(snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const EventsLoadingScreen();
                          case ConnectionState.done:
                          default:
                            if (snapshot.hasData) {
                              List<Event> events = snapshot.data;
                              return buildEvents(context, events);
                            } else {
                              return const EventsLoadingScreen();
                            }
                        }
                        
                      })))
            ])));
  }
}

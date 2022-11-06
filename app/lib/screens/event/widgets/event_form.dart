import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/dummy_data.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/image_model.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/event/widgets/cover_image.dart';
import 'package:good_karma_app/screens/event/widgets/select_image_modal.dart';
import 'package:good_karma_app/services/storage_service.dart';
import 'package:good_karma_app/utils/extension.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/custom_drop_down.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';
import 'package:good_karma_app/models/event_locations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

const EventDateTimeFormat = "dd MMM yy, h:mm a";

class EventForm extends StatefulWidget {
  final Function(Event) onSave;
  final String title;
  final Event? originalEvent;

  const EventForm(
      {Key? key, required this.onSave, required this.title, this.originalEvent})
      : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  /* State variables */
  ImageModel? coverImage;
  String? name;
  String? description;
  int? volunteersNeeded;
  DateTime? startDateTime;
  DateTime? endDateTime;
  Location? category;
  String? location;

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _locationsDropdownMenu =
        _buildLocationsModelDropdown(locationsList);
    _locationsModel = locationsList[0];
    startTimeController.text = formatDate(widget.originalEvent?.eventDateTime);
    endTimeController.text = formatDate(widget.originalEvent?.endDateTime);
    startDateTime = widget.originalEvent?.eventDateTime;
    endDateTime = widget.originalEvent?.endDateTime;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Location _locationsModel =
      Location(null, 'Select Location', true);
  late List<DropdownMenuItem<Location>>
      _locationsDropdownMenu;

  List<DropdownMenuItem<Location>> _buildLocationsModelDropdown(
      List categoriesModelList) {
    List<DropdownMenuItem<Location>>? items = [];
    for (Location location in categoriesModelList) {
      items.add(DropdownMenuItem(
        value: location,
        child: Text(location.name),
      ));
    }
    return items;
  }

  _onChangeLocationsModelDropdown(Location? locationsModel) {
    setState(() {
      _locationsModel = locationsModel!;
    });
  }

  Future onSourceSelected(ImageSource source) async {
    XFile? image = (await picker.pickImage(source: source, imageQuality: 100));

    setState(() {
      if (image != null) {
        debugPrint("File: " + image.path);
        coverImage = ImageModel(-1, image.path, File(image.path));
      }
    });

    Navigator.pop(context);
  }

  onSaveName(String? input) {
    name = input;
  }

  onValidateName(String? input) {
    if (input == null || input.isEmpty) {
      return "Missing Event Name";
    }
    return null;
  }

  onSaveDescription(String? input) {
    description = input;
  }

  onValidateDescription(String? input) {
    if (input == null || input.isEmpty) {
      return "Missing Description";
    }
    return null;
  }

  onSaveVolunteersNeeded(String? input) {
    volunteersNeeded = input != null ? int.parse(input) : null;
  }

  onValidateVolunteersNeeded(String? input) {
    if (input == null || input.isEmpty) {
      return "Missing volunteers needed";
    }
    if (int.parse(input) <= 0) {
      return "Invalid volunteers needed count";
    }
    return null;
  }

  onValidateDateTime(String? input) {
    if (input == null || input.isEmpty) {
      return "Missing date of event";
    }
    return null;
  }

  onSaveLocation(String? input) {
    location = input;
  }

  onValidateLocation(String? input) {
    if (input == null || input.isEmpty) {
      return "Missing location";
    }
    return null;
  }

  editCoverImage(BuildContext context) {
    debugPrint("Pressed Edit Cover image");

    showBarModalBottomSheet(
        context: context,
        builder: (context) => SelectImageModal(
            onSourceSelected: onSourceSelected, width: context.width));
  }

  Future<DateTime?> _showSelectToDate(DateTime? initialDate) async {
    return await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
  }

  Future<TimeOfDay?> _showSelectToTime(TimeOfDay? initialTime) async {
    return await showTimePicker(
        context: context,
        initialTime: initialTime ?? TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
  }

  String formatDate(DateTime? d) {
    if (d != null) {
      return DateFormat(EventDateTimeFormat).format(d);
    }
  return "";
  }

  DateTime mergeDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
          date.year,
          date.month, 
          date.day, 
          time.hour, 
          time.minute);
  }

  TimeOfDay? timeFromNullable(DateTime? d) {
    return d != null ?
     TimeOfDay.fromDateTime(d) :
     null;
  }

  onSelectStartDateTime() async {
    DateTime? newDate = await _showSelectToDate(startDateTime);
    TimeOfDay? newTime;

    if (newDate != null) {
      newTime = await _showSelectToTime(timeFromNullable(startDateTime));
    }

    if (newTime != null) {
      setState(() {
        startDateTime = mergeDateAndTime(newDate!, newTime!);
        startTimeController.text = formatDate(startDateTime);
      });
    }
  }

  onSelectEndDateTime() async {
    DateTime? newDate = await _showSelectToDate(endDateTime);
    TimeOfDay? newTime;

    if (newDate != null) {
      newTime = await _showSelectToTime(timeFromNullable(endDateTime));
    }

    if (newTime != null) {
      setState(() {
        endDateTime = mergeDateAndTime(newDate!, newTime!);
        endTimeController.text = formatDate(endDateTime);
      });
    }
  }

  onNext() async {
    debugPrint("Pressed next");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("Valid input");

      String? coverImageUrl = widget.originalEvent?.imageUrl;
      if (coverImage?.imagePath != null) {
        coverImageUrl =
            await Provider.of<StorageService>(context, listen: false)
                .uploadEventImage(null, coverImage!.file);
      }

      UserData user = Provider.of<UserData>(context, listen: false);

      int durationMinutes = 0;
      if (startDateTime != null && endDateTime != null) {
        durationMinutes = endDateTime!.difference(startDateTime!).inMinutes;
      }

      Event event = Event(
          id: widget.originalEvent?.id,
          title: name,
          location: _locationsModel.id,
          description: description,
          imageUrl: coverImageUrl,
          eventCategory: category?.toString(),
          karmaPoints: 5,
          eventDateTime: startDateTime,
          endDateTime: endDateTime,
          volunteersNeeded: volunteersNeeded,
          creatorUserId: user.currentUserId,
          creatorName: user.currentUserFullName,
          createdDateTime:
              widget.originalEvent?.createdDateTime ?? DateTime.now(),
          durationMinutes: durationMinutes,
          public: false);

      widget.onSave(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: boldTextStyle.copyWith(fontSize: 24.0)),
                    const SizedBox(height: 20.0),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Event Image',
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              const SizedBox(height: 16.0),
                              CoverImage(
                                  onEditImage: () => editCoverImage(context),
                                  imagePath: coverImage?.imagePath ??
                                      widget.originalEvent?.imageUrl,
                                  isNetworkImage: coverImage?.imagePath ==
                                          null &&
                                      widget.originalEvent?.imageUrl != null),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("Event Name",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              TextFormWidget(
                                  initialValue: widget.originalEvent?.title,
                                  hintText: "Type here",
                                  onValidation: onValidateName,
                                  onSaved: onSaveName),
                              const SizedBox(height: 20.0),
                              Text("Description",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              TextFormWidget(
                                  initialValue:
                                      widget.originalEvent?.description,
                                  maxLines: 8,
                                  onValidation: onValidateDescription,
                                  onSaved: onSaveDescription),
                              const SizedBox(height: 20.0),
                              Text("Estimate number of volunteers needed",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              TextFormWidget(
                                  initialValue: widget
                                      .originalEvent?.volunteersNeeded
                                      .toString(),
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                          signed: false, decimal: false),
                                  onValidation: onValidateVolunteersNeeded,
                                  onSaved: onSaveVolunteersNeeded),
                              const SizedBox(height: 20.0),
                              Text("Start Date & Time",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              InkWell(
                                child: TextFormWidget(
                                    textEditingController: startTimeController,
                                    hintText: "Select Start Date & Time",
                                    readOnly: false,
                                    onValidation: onValidateDateTime),
                                onTap: onSelectStartDateTime,
                              ),
                              const SizedBox(height: 20.0),
                              Text("End Date & Time",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              InkWell(
                                child: TextFormWidget(
                                    textEditingController: endTimeController,
                                    hintText: "Select End Date & Time",
                                    readOnly: false,
                                    onValidation: onValidateDateTime),
                                onTap: onSelectEndDateTime,
                              ),
                              const SizedBox(height: 20.0),
                              Text("Event Location",
                                  style:
                                      normalTextStyle.copyWith(fontSize: 14.0)),
                              CustomDropdown(
                                  dropdownMenuItemList:
                                      _locationsDropdownMenu,
                                  onChanged: _onChangeLocationsModelDropdown,
                                  value: _locationsModel,
                                ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                        alignment: Alignment.center,
                        child: ActionButton(
                            width: 252,
                            height: 58,
                            text: "NEXT",
                            onPressed: onNext))
                  ])),
        ));
  }
}

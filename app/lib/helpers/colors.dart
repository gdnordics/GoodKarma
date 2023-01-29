import 'package:flutter/material.dart';

class AppColor {
  static const itemBackgroundColor = Color(0xFFD1D1D1);
}

const subtitleColor = Color(0x55353436);

const approvedEventColor = Color(0xFF47C644);
const deleteEventIconColor = Color.fromARGB(255, 39, 39, 39);
const deleteEventQuestionColor = Color(0xFFEB5757);
const cancelRequestToAttendColor = Color(0xFFEB5757);
const undoActionColor = Color(0xFFE89E35);

const addQuestionsColor = Color(0xFF00B6AA);
const publishButtonColor = Color(0xFFE62A2A);
const disabledButtonColor = Color.fromARGB(255, 112, 112, 112);
const disabledButtonTextColor = Color.fromARGB(255, 142, 142, 142);
//Used for date of event & organizer
//Create event form grey color. Also used for eventlist for location
const formGreyColor = Color(0xFF747688);

const volunteerApplicationFormApplyBtnColor = Color(0xFF00B6AA);
const signedupEventCancelBtnColor = Color(0xFFCF3333);

//const backgroundColor = Color.fromARGB(255, 255, 255, 255);
const backgroundColor = Color(0xFFFFFAEA);
const panelColor = Color.fromARGB(255, 255, 255, 255);

const mainLoadingScreenColor = Color(0xFFFFFAEA);

const toastTextColor = Color.fromARGB(255, 241, 241, 241);



const shadowColor = Color(0x77DDDDDD);
const shadowBorderColor = Color(0xFFDDDDDD);



//primary text color - all text in app with this color except buttons & forms 
const primaryTextColor = Color.fromARGB(255, 95, 95, 95);

const secondaryTextColor = Color.fromARGB(255, 209, 209, 209);

const answerTextColor = Color(0xFF11B233);
//in form placeholder font color
const kEditTextHintColor = Color(0xFF747688);
//primary text color inside buttons
const kBtnBgTextColor = Color(0xFFFFFFFF);
//color for displaying event date in event detail page (the blue square - Nov 14 2022)
const kEventDateTextColor = Color(0xFFDDE0FB);

const kEditTextPrimaryColor = Color(0xFF807A7A);

//in form placeholder font color
// const kEditTextHintColor = Color(0xFF747688);
const kEditTextBorderColor = Color(0xFFE4DFDF);

const kEditButtonTextColor = Color(0xFF2A3FE6);
const kEditButttonBGColor = Color(0XFFFFFFFF);
const kEditButtonIconBGColor = Color(0xFF3D56F0);

const kLoginButtonTextColor = Color(0XFFFFFFFF);
const kLoginButttonBGColor = Color(0xFF2A3FE6);
const kLoginButtonIconBGColor = Color(0xFF3D56F0);

const kThirdPartyLoginButttonBGColor = Color(0XFFFFFFFF);
const kThirdPartyLoginButtonTextColor = Color(0xFF000000);

const toggleFieldActiveColor = Color(0xFF2A3FE6);
const toggleFieldActiveTextColor = Color(0xFFFFFFFF);

const toggleFieldColor = Color.fromARGB(255, 234, 238, 242);
const toggleFieldTextColor = Color(0xFFB9C1C9);

const primaryLightGreenColor = Color(0xFF11B233);
const primaryDarkGreenColor = Color(0xFF366740);
const primaryColor = primaryLightGreenColor;
const primayBackdropColor = Color(0x3311B233);

const forwardActionIconBGColor = Color(0x77366740);

const mainLoadingScreenTextColor = Color(0xFF11B233);

Map<int, Color> color =
{
50:Color.fromRGBO(17, 178, 51, .1),
100:Color.fromRGBO(17, 178, 51, .2),
200:Color.fromRGBO(17, 178, 51, .3),
300:Color.fromRGBO(17, 178, 51, .4),
400:Color.fromRGBO(17, 178, 51, .5),
500:Color.fromRGBO(17, 178, 51, .6),
600:Color.fromRGBO(17, 178, 51, .7),
700:Color.fromRGBO(17, 178, 51, .8),
800:Color.fromRGBO(17, 178, 51, .9),
900:Color.fromRGBO(17, 178, 51, 1),
};

MaterialColor primarySwatchColor = MaterialColor(primaryLightGreenColor.hashCode, color);
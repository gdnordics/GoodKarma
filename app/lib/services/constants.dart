import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'europe-west1');

final searchFunc = _functions.httpsCallable('search');

final usersRef = _db.collection('users');

final eventsRef = _db.collection('events');
final userEventsRef = _db.collection('user_events');
final eventQuestionsRef = _db.collection('event_questions');
final requestsToAttendRef = _db.collection('requests_to_attend');
final FirebaseStorage _storage = FirebaseStorage.instance;
final storageRef = _storage.ref();

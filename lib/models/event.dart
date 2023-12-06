import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:latlong2/latlong.dart';

class Event {
  final String eid;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final Address address;
  final List<String> attendeeIDs;
  final List<String> organiserIDs;
  final EventType eventType;
  final LatLng latLng;

  Event({
    required this.eid,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.attendeeIDs,
    required this.organiserIDs,
    required this.eventType,
    required this.description,
    required this.latLng,
  });

  Map<String, dynamic> toFirestore() => {
        "eid": eid,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "address": address.toJson(),
        "attendees": attendeeIDs,
        "organisers": organiserIDs,
        "event_type": eventType.number,
        "description": description,
        "lat_lng": latLng.toJson(),
        "search_name": name.toLowerCase()
      };

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    var d = snapshot.id;
    return Event(
      eid: d,
      name: data!['name'],
      startDate: DateTime.parse(data['start_date'].toDate().toString()),
      endDate: DateTime.parse(data['end_date'].toDate().toString()),
      address: Address.fromJson(data['address']),
      attendeeIDs: List.from(data['attendees']),
      organiserIDs: List.from(data['organisers']),
      eventType: EventType.values[data['event_type']],
      description: data['description'],
      latLng: LatLng.fromJson(data['lat_lng']),
    );
  }

  @override
  String toString() => name;
}

enum EventType {
  public(0, 'Public'),
  private(1, 'Private'),
  friend(2, 'Friend');

  const EventType(this.number, this.value);

  final int number;
  final String value;
}

class EventArguments {
  final Event event;

  EventArguments({required this.event});
}


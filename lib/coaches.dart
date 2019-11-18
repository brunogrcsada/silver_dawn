import 'package:silver_dawn/trips.dart';

class Coaches {
  int _coachID;
  String _registration;
  int _seats;

  Coaches(this._registration, [this._seats]);
  Coaches.withId(this._coachID, this._registration, [this._seats]);

  int get coachID => _coachID;
  String get registration => _registration;
  int get seats => _seats;
  List get variableList => ["", ""];


  set registration(String coachRegistration) {
    if (coachRegistration.length <= 255) {
      this._registration = coachRegistration;
    }
  }

  set seats(int coachSeats) {
      this._seats = coachSeats;
  }


  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (coachID != null) {
      map['coach_id'] = _coachID;
    }
    map['registration'] = _registration;
    map['seats'] = _seats;

    return map;
  }

  Coaches.fromMapObject(Map<String, dynamic> map) {
    this._coachID = map['coach_id'];
    this._registration = map['registration'];
    this._seats = map['seats'];

  }

}
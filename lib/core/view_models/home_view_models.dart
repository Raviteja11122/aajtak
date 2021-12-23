import 'dart:async';

import 'package:flutter/material.dart';
import 'package:india_today_task/core/models/models.dart';
import 'package:india_today_task/core/services/api.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends BaseViewModel{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  DateTime _date;
  TextEditingController _dateController;
  TextEditingController _locationController;
  TextEditingController _searchController;
  String _placeId;
  final Api _api = Api();
  final StreamController<PanchangModel> _streamController = StreamController<PanchangModel>.broadcast();
  final StreamController<List<AgentModel>> _agentsStreamController = StreamController<List<AgentModel>>.broadcast();
  PanchangModel _panchangModel;
  List<AgentModel> _agents;
  int _sortBy;
  int _languageFilterId;
  int _skillsFilterId;

  final Map<int, dynamic> _sortByOptions = {
    1: "Experience - Low to High",
    2: "Experience - High to Low",
    3: "Price - Low to High",
    4: "Price - High to Low",
  };

  final Map<int, dynamic> _languageFilter = {
    1: "English",
    2: "Hindi",
    3: "Telugu"
  };

  final Map<int, dynamic> _skillsFilter = {
    1: "Vastu",
    2: "Numerology",
    3: "Vedic Astrology",
    4: "Kundali Grah Dosh",
    5: "Tarot",
    6: "Palmistry",
    7: "Coffe Cup Reading",
    8: "Face Reading"
  };

  bool _enableSearch = false;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get tabIndex => _tabIndex;
  TextEditingController get dateEditingController => _dateController;
  TextEditingController get locationEditingController => _locationController;
  TextEditingController get searchEditingController => _searchController;
  Stream<PanchangModel> get panchang => _streamController.stream;
  Stream<List<AgentModel>> get agents => _agentsStreamController.stream;
  int get sortBy => _sortBy;
  int get languageFilterId => _languageFilterId;
  int get skillsFilterId => _skillsFilterId;
  bool get enableSearch => _enableSearch;
  Map<int, dynamic> get sortByOptions => _sortByOptions;
  Map<int, dynamic> get languageFilter => _languageFilter;
  Map<int, dynamic> get skillsFilter => _skillsFilter;

  initialize(){
    _dateController = TextEditingController();
    _locationController = TextEditingController();
    _searchController = TextEditingController();
    getAgents();
  }

  openDatePicker(BuildContext context)async{
    DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      initialDate: _date ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5))
    );

    /// Check if user selected new date and time or not
    if(picked != null && picked != _date) {
      _date = picked;
      _dateController.text = DateFormat.yMMMMd().add_jm().format(_date);
      getPanchang();
    }
  }

  setTabIndex(int index){
    _tabIndex = index;
    Future.delayed(const Duration(seconds: 1), () {
      if(index == 0)
        _streamController.add(_panchangModel);
      else if(index == 1)
        _agentsStreamController.add(_agents);
    });
    notifyListeners();
  }

  Future<List<Places>> getCities(String pattern)async{
    return _api.getPlaces(pattern);
  }

  getPanchang()async{
    if(_placeId != null && _date != null){
      Map<String, dynamic> body = {
        "day": _date.day,
        "month": _date.month,
        "year": _date.year,
        "placeId": _placeId
      };
      _panchangModel = await _api.getPanchang(body);
      _streamController.add(_panchangModel);
    }
  }

  getAgents()async{
    _agents = await _api.getAgents();
    _agentsStreamController.add(_agents);
  }

  void setPlaceId(String placeId) {
    _placeId = placeId;
    getPanchang();
  }

  void setSortBy(int value) {
    _sortBy = value;
    filterAgents();
    notifyListeners();
  }

  void toggleSearch(){
    _enableSearch = !_enableSearch;
    if(!_enableSearch){
      _searchController.text = "";
    }
    filterAgents();
    notifyListeners();
  }

  filterAgents(){
    List<AgentModel> _searchAgents = _agents;
    /// search agents by search field
    if(_searchController.text.trim() != null && _searchController.text.trim().trim().isNotEmpty){
      _searchAgents = _searchAgents.where((e) =>
        (
          e.firstName.toLowerCase().contains(_searchController.text.toLowerCase().trim())
          || e.lastName.toLowerCase().contains(_searchController.text.toLowerCase().trim())
          || (e.skills.where((element) => element.name.toLowerCase().contains(_searchController.text.toLowerCase().trim())).toList().isNotEmpty)
          || (e.languages.where((element) => element.name.toLowerCase().contains(_searchController.text.toLowerCase().trim())).toList().isNotEmpty)
        )
      ).toList();
    }

    List<AgentModel> _filteredAgents = _searchAgents;
    /// adding language filter to agent list
    if(_languageFilterId != null){
      _filteredAgents.addAll(_searchAgents.where((e) =>
        e.languages.where((element) => element.name.contains(_languageFilter[_languageFilterId])).toList().isNotEmpty
      ).toList());
    }

    /// adding skills filter to agent list
    if(_skillsFilterId != null){
      _filteredAgents.addAll(_searchAgents.where((e) =>
        e.skills.where((element) => element.name.contains(_skillsFilter[_skillsFilterId])).toList().isNotEmpty
      ).toList());
    }

    /// Removing duplicates
    _filteredAgents = [...{..._filteredAgents}];

    /// Sort results
    if(_sortBy != null){
      if(_sortBy == 1) {
        _filteredAgents.sort((a, b) => a.experience.compareTo(b.experience));
      }else if(_sortBy == 2){
        _filteredAgents.sort((a, b) => b.experience.compareTo(a.experience));
      }else if(_sortBy == 3){
        _filteredAgents.sort((a, b) => a.minimumCallDurationCharges.compareTo(b.minimumCallDurationCharges));
      }else {
        _filteredAgents.sort((a, b) => b.minimumCallDurationCharges.compareTo(a.minimumCallDurationCharges));
      }
    }
    _agentsStreamController.add(_filteredAgents);
  }

  void setLanguageFilter(int value) {
    _languageFilterId = value;
    filterAgents();
    notifyListeners();
  }

  void setSkillsFilter(int value) {
    _skillsFilterId = value;
    filterAgents();
    notifyListeners();
  }
}
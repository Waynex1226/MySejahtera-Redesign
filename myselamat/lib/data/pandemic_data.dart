import 'dart:convert';

class DataEntry {
  final Map _data;

  DataEntry(this._data);

  int get confirmed {
    return _data["confirmed"];
  }

  int get recovered {
    return _data["recovered"];
  }

  int get death {
    return _data["death"];
  }
}

class TopGlobalData {
  final Map _topGlobalData;

  TopGlobalData(this._topGlobalData);

  String get name {
    return _topGlobalData["name"];
  }

  int get confirmed {
    return _topGlobalData["confirmed"];
  }

  int get death {
    return _topGlobalData["death"];
  }
}

class AseanData {
  final Map _aseanData;

  AseanData(this._aseanData);

  String get name {
    return _aseanData["name"];
  }

  int get confirmed {
    return _aseanData["confirmed"];
  }
}

class GlobalData {
  final Map _globalData;

  GlobalData(this._globalData);

  DataEntry get total {
    return DataEntry(_globalData["full"]["total"]);
  }

  DataEntry get today {
    return DataEntry(_globalData["full"]["today"]);
  }

  List<TopGlobalData> topGlobal({int topN = 5}) {
    List<TopGlobalData> areaData = [];

    for (int i = 0; i < (topN % _globalData["top_global"].length); i++) {
      areaData.add(TopGlobalData(_globalData["top_global"][i]));
    }

    return areaData;
  }

  List<AseanData> get asean {
    return _globalData["asean"].map((data) => AseanData(data)).toList();
  }
}

class StateData {
  final Map _statesData;

  StateData(this._statesData);

  DataEntry get total {
    return DataEntry(_statesData["total"]);
  }

  DataEntry get today {
    return DataEntry(_statesData["today"]);
  }
}

class LocalData {
  final Map _data;

  LocalData(this._data);

  DataEntry get total {
    return DataEntry(_data["full"]["total"]);
  }

  DataEntry get today {
    return DataEntry(_data["full"]["today"]);
  }

  List<StateData> get states {
    return _data["states"].map((data) => StateData(data)).toList();
  }
}

class PandemicData {
  /// Highest level wrapper for all pandemic data
  late GlobalData _globalData;
  late LocalData _localData;
  late Map _data;

  PandemicData() {
    _data = jsonDecode('''
      {
    "timestamp": 1622902560134,
    "global": {
        "full": {
            "total": {"confirmed": 173343731, "recovered": 154624920, "death": 3728526, "active": 14990285},
            "today": {"confirmed": 420523, "recovered": 482049, "death": 10232, "active": -71758}
        },
        "top_global": [
            {"name": "united_states", "confirmed": 34192023, "death": 612240},
            {"name": "india", "confirmed": 28694879, "death": 344101},
            {"name": "brazil", "confirmed": 16841954, "death": 470678},
            {"name": "france", "confirmed": 34192023, "death": 612240},
            {"name": "turkey", "confirmed": 34192023, "death": 612240},
            {"name": "russia", "confirmed": 34192023, "death": 612240},
            {"name": "united_kingdom", "confirmed": 34192023, "death": 612240},
            {"name": "italy", "confirmed": 34192023, "death": 612240},
            {"name": "argentina", "confirmed": 34192023, "death": 612240},
            {"name": "germany", "confirmed": 34192023, "death": 612240}
        ],
        "asean": [
            {"name": "indonesia", "confirmed": 34192023},
            {"name": "philippines", "confirmed": 1262273},
            {"name": "malaysia", "confirmed": 610574},
            {"name": "thailand", "confirmed": 174796},
            {"name": "myanmar", "confirmed": 144157},
            {"name": "singpoare", "confirmed": 62176},
            {"name": "cambodia", "confirmed": 33613},
            {"name": "vietnam", "confirmed": 8458},
            {"name": "laos", "confirmed": 1957},
            {"name": "brunei", "confirmed": 141}
        ]
    },
    "local": {
        "full": {
            "r_value": 1.03,
            "total": {"confirmed": 610574, "recovered": 521676, "death": 3291, "active": 85607},
            "today": {"confirmed": 7452, "recovered": 6105, "death": 109, "active": 1238}
        },
        "states": [
            {"name": "selangor",
                "today": {"confirmed": 2509},
                "total": {"confirmed": 199968}
            },
            {"name": "sabah",
                "today": {"confirmed": 259},
                "total": {"confirmed": 63565}
            },
            {"name": "kuala_lumpur",
                "today": {"confirmed": 678},
                "total": {"confirmed": 62502}
            },
            {"name": "johor",
                "today": {"confirmed": 412},
                "total": {"confirmed": 60978}
            },
            {"name": "sarawak",
                "today": {"confirmed": 651},
                "total": {"confirmed": 50571}
            },
            {"name": "penang",
                "today": {"confirmed": 370},
                "total": {"confirmed": 30482}
            },
            {"name": "kelantan",
                "today": {"confirmed": 312},
                "total": {"confirmed": 29872}
            },
            {"name": "negeri_sembilan",
                "today": {"confirmed": 843},
                "total": {"confirmed": 29416}
            },
            {"name": "perak",
                "today": {"confirmed": 252},
                "total": {"confirmed": 22252}
            },
            {"name": "kedah",
                "today": {"confirmed": 263},
                "total": {"confirmed": 20327}
            },
            {"name": "melaka",
                "today": {"confirmed": 206},
                "total": {"confirmed": 13306}
            },
            {"name": "pahang",
                "today": {"confirmed": 286},
                "total": {"confirmed": 10571}
            },
            {"name": "terengganu",
                "today": {"confirmed": 190},
                "total": {"confirmed": 9713}
            },
            {"name": "labuan",
                "today": {"confirmed": 205},
                "total": {"confirmed": 4540}
            },
            {"name": "putrajaya",
                "today": {"confirmed": 12},
                "total": {"confirmed": 1976}
            },
            {"name": "perlis",
                "today": {"confirmed": 4},
                "total": {"confirmed": 535}
            }
        ]
    }
}
    ''');
    _globalData = GlobalData(_data["global"]);
    _localData = LocalData(_data["local"]);
  }

  int get timestamp {
    return _data["timestamp"];
  }

  GlobalData get global {
    return _globalData;
  }

  LocalData get local {
    return _localData;
  }
}

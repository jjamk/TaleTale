//지정된 터미널의 정보를 담은 api의 정보를 처리하기 위한 클래스
class lin_list_Terminal {
  final String bafTyn;
  final String terEnm;
  final String sysDvsCod;
  final String locCod;
  final String terCod;
  final String terNam;

  lin_list_Terminal({
    required this.bafTyn,
    required this.terEnm,
    required this.sysDvsCod,
    required this.locCod,
    required this.terCod,
    required this.terNam,
  });

  factory lin_list_Terminal.fromJson(Map<String, dynamic> json) {
    return lin_list_Terminal(
      bafTyn: json['BAF_TYN'],
      terEnm: json['TER_ENM'],
      sysDvsCod: json['SYS_DVS_COD'],
      locCod: json['LOC_COD'],
      terCod: json['TER_COD'],
      terNam: json['TER_NAM'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'BAF_TYN': bafTyn,
      'TER_ENM': terEnm,
      'SYS_DVS_COD': sysDvsCod,
      'LOC_COD': locCod,
      'TER_COD': terCod,
      'TER_NAM': terNam,
    };
  }

}

class lin_list_ApiResponse {
  final String code;
  final String message;
  final List<lin_list_Terminal> terList;

  lin_list_ApiResponse({
    required this.code,
    required this.message,
    required this.terList,
  });

  factory lin_list_ApiResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? terListJson = json['response']['TER_LIST'];
    final terList = terListJson?.map((item) => lin_list_Terminal.fromJson(item)).toList() ?? [];

    return lin_list_ApiResponse(
      code: json['code'],
      message: json['message'],
      terList: terList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'response': {
        'TER_LIST': terList.map((terminal) => terminal.toJson()).toList(),
      },
    };
  }
}
//전체 터미널의 정보를 담은 api의 정보를 처리하기 위한 클래스
class load_info_ApiResponse {
  final String code;
  final String message;
  final load_info_ResponseData response;

  load_info_ApiResponse({
    required this.code,
    required this.message,
    required this.response,
  });

  factory load_info_ApiResponse.fromJson(Map<String, dynamic> json) {
    return load_info_ApiResponse(
      code: json['code'],
      message: json['message'],
      response: load_info_ResponseData.fromJson(json['response']),
    );
  }
}

class load_info_ResponseData {
  final String inDate;
  final List<load_info_Terminal> terList;
  final String resultStatus;
  final List<load_info_Company> corList;

  load_info_ResponseData({
    required this.inDate,
    required this.terList,
    required this.resultStatus,
    required this.corList,
  });

  factory load_info_ResponseData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> terListJson = json['TER_LIST'];
    final terList = terListJson.map((item) => load_info_Terminal.fromJson(item)).toList();

    final List<dynamic> corListJson = json['COR_LIST'];
    final corList = corListJson.map((item) => load_info_Company.fromJson(item)).toList();

    return load_info_ResponseData(
      inDate: json['IN_DATE'],
      terList: terList,
      resultStatus: json['RESULT_STATUS'],
      corList: corList,
    );
  }
}

class load_info_Terminal {
  final String terFrYn;
  final String bafTyn;
  final String terAdr;
  final String terNam;
  final String dblCod;
  final String jobCod;
  final String terLat;
  final String tagDvs;
  final String terCod;
  final String locCod;
  final String terToYn;
  final String terTrn;
  final String terLon;
  final String terEnm;
  final String sysDvsCod;

  load_info_Terminal({
    required this.terFrYn,
    required this.bafTyn,
    required this.terAdr,
    required this.terNam,
    required this.dblCod,
    required this.jobCod,
    required this.terLat,
    required this.tagDvs,
    required this.terCod,
    required this.locCod,
    required this.terToYn,
    required this.terTrn,
    required this.terLon,
    required this.terEnm,
    required this.sysDvsCod,
  });

  factory load_info_Terminal.fromJson(Map<String, dynamic> json) {
    return load_info_Terminal(
      terFrYn: json['TER_FR_YN'],
      bafTyn: json['BAF_TYN'],
      terAdr: json['TER_ADR'],
      terNam: json['TER_NAM'],
      dblCod: json['DBL_COD'],
      jobCod: json['JOB_COD'],
      terLat: json['TER_LAT'],
      tagDvs: json['TAG_DVS'],
      terCod: json['TER_COD'],
      locCod: json['LOC_COD'],
      terToYn: json['TER_TO_YN'],
      terTrn: json['TER_TRN'],
      terLon: json['TER_LON'],
      terEnm: json['TER_ENM'],
      sysDvsCod: json['SYS_DVS_COD'],
    );
  }
}

class load_info_Company {
  final String corCod;
  final String corNam;

  load_info_Company({
    required this.corCod,
    required this.corNam,
  });

  factory load_info_Company.fromJson(Map<String, dynamic> json) {
    return load_info_Company(
      corCod: json['COR_COD'],
      corNam: json['COR_NAM'],
    );
  }
}

// 지정된 노선에 대한 정보를 담은 api의 정보를 처리하기 위한 클래스
class ibt_list_ApiResponse {
  final String code;
  final String message;
  final ibt_list_ApiResponseData response;

  ibt_list_ApiResponse({
    required this.code,
    required this.message,
    required this.response,
  });

  factory ibt_list_ApiResponse.fromJson(Map<String, dynamic> json) {
    return ibt_list_ApiResponse(
      code: json['code'],
      message: json['message'],
      response: ibt_list_ApiResponseData.fromJson(json['response']),
    );
  }
}

class ibt_list_ApiResponseData {
  final List<Line> lineList;
  final String timDte;

  ibt_list_ApiResponseData({
    required this.lineList,
    required this.timDte,
  });

  factory ibt_list_ApiResponseData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> lineListJson = json['LINE_LIST'];
    final lineList = lineListJson.map((item) => Line.fromJson(item)).toList();

    return ibt_list_ApiResponseData(
      lineList: lineList,
      timDte: json['TIM_DTE'],
    );
  }
}

class Line {
  final String timTimO;
  final String terToI;
  final String remCnt;
  final String tckPay;
  final String ticCod;
  final String terToO;
  final String corCodO;
  final String seatYn;
  final String afcOwnrDvsCd;
  final String terFrI;
  final String alcnWayDvsCd;
  final String alcnDt;
  final String terFrO;
  final String terPfr;
  final String sysDiv;
  final String corNam;
  final String rotId;
  final String busGraO;
  final String rotSqno;
  final String alcnSqno;
  final String linTim;
  final String timTim;
  final String dcPsbYn;
  final String tagDvs;
  final String webCnt;

  Line({
    required this.timTimO,
    required this.terToI,
    required this.remCnt,
    required this.tckPay,
    required this.ticCod,
    required this.terToO,
    required this.corCodO,
    required this.seatYn,
    required this.afcOwnrDvsCd,
    required this.terFrI,
    required this.alcnWayDvsCd,
    required this.alcnDt,
    required this.terFrO,
    required this.terPfr,
    required this.sysDiv,
    required this.corNam,
    required this.rotId,
    required this.busGraO,
    required this.rotSqno,
    required this.alcnSqno,
    required this.linTim,
    required this.timTim,
    required this.dcPsbYn,
    required this.tagDvs,
    required this.webCnt,
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      timTimO: json['TIM_TIM_O'],
      terToI: json['TER_TO_I'],
      remCnt: json['REM_CNT'],
      tckPay: json['TCK_PAY'],
      ticCod: json['TIC_COD'],
      terToO: json['TER_TO_O'],
      corCodO: json['COR_COD_O'],
      seatYn: json['SEAT_YN'],
      afcOwnrDvsCd: json['AFC_OWNR_DVS_CD'],
      terFrI: json['TER_FR_I'],
      alcnWayDvsCd: json['ALCN_WAY_DVS_CD'],
      alcnDt: json['ALCN_DT'],
      terFrO: json['TER_FR_O'],
      terPfr: json['TER_PFR'],
      sysDiv: json['SYS_DIV'],
      corNam: json['COR_NAM'],
      rotId: json['ROT_ID'],
      busGraO: json['BUS_GRA_O'],
      rotSqno: json['ROT_SQNO'],
      alcnSqno: json['ALCN_SQNO'],
      linTim: json['LIN_TIM'],
      timTim: json['TIM_TIM'],
      dcPsbYn: json['DC_PSB_YN'],
      tagDvs: json['TAG_DVS'],
      webCnt: json['WEB_CNT'],
    );
  }
}

class ibt_info_ApiResponse {
  String code;
  String message;
  ibt_info_ResponseData response;

  ibt_info_ApiResponse({required this.code, required this.message, required this.response});

  factory ibt_info_ApiResponse.fromJson(Map<String, dynamic> json) {
    return ibt_info_ApiResponse(
      code: json['code'],
      message: json['message'],
      response: ibt_info_ResponseData.fromJson(json['response']),
    );
  }
}

// 완벽히 지정된 노선에 대한 좌석 여부와 요금 데이터를 받아오는 api의 정보를 처리하기 위한 클래스
class ibt_info_ResponseData {
  String? preDcRngTim;
  String? totCnt;
  String? seatDcRto;
  String? occNCnt;
  String? ibtSeatType;
  String? occYCnt;
  String? seatDcTarget;
  List<ibt_info_Seat> seatList;
  String? busClsPrinYn;
  String? preOccDcRto;
  String? jntDcRto;
  String? seatDcFee;
  String? satsNoPrinYn;
  String? rndDcRto;
  String? busCacmNmPrinYn;
  String? dist;
  List<ibt_info_Lin> linList;
  String? tckFee1;
  String? tckFee2;
  String? preOccDcFee;
  String? dcPsbYn;
  String? jntDcFee;
  String? tckFee9;
  String? deprTimePrinYn;
  String? tckFee92;
  String? rndDcFee;
  String? takeDrtm;

  ibt_info_ResponseData({
    this.preDcRngTim,
    this.totCnt,
    this.seatDcRto,
    this.occNCnt,
    this.ibtSeatType,
    this.occYCnt,
    this.seatDcTarget,
    required this.seatList,
    this.busClsPrinYn,
    this.preOccDcRto,
    this.jntDcRto,
    this.seatDcFee,
    this.satsNoPrinYn,
    this.rndDcRto,
    this.busCacmNmPrinYn,
    this.dist,
    required this.linList,
    this.tckFee1,
    this.tckFee2,
    this.preOccDcFee,
    this.dcPsbYn,
    this.jntDcFee,
    this.tckFee9,
    this.deprTimePrinYn,
    this.tckFee92,
    this.rndDcFee,
    this.takeDrtm,
  });

  factory ibt_info_ResponseData.fromJson(Map<String, dynamic> json) {
    return ibt_info_ResponseData(
      preDcRngTim: json['PRE_DC_RNG_TIM'],
      totCnt: json['TOT_CNT'],
      seatDcRto: json['SEAT_DC_RTO'],
      occNCnt: json['OCC_N_CNT'],
      ibtSeatType: json['IBT_SEAT_TYPE'],
      occYCnt: json['OCC_Y_CNT'],
      seatDcTarget: json['SEAT_DC_TARGET'],
      seatList: List<ibt_info_Seat>.from(json['SEAT_LIST'].map((x) => ibt_info_Seat.fromJson(x))),
      busClsPrinYn: json['BUS_CLS_PRIN_YN'],
      preOccDcRto: json['PRE_OCC_DC_RTO'],
      jntDcRto: json['JNT_DC_RTO'],
      seatDcFee: json['SEAT_DC_FEE'],
      satsNoPrinYn: json['SATS_NO_PRIN_YN'],
      rndDcRto: json['RND_DC_RTO'],
      busCacmNmPrinYn: json['BUS_CACM_NM_PRIN_YN'],
      dist: json['DIST'],
      linList: List<ibt_info_Lin>.from(json['LIN_LIST'].map((x) => ibt_info_Lin.fromJson(x))),
      tckFee1: json['TCK_FEE1'],
      tckFee2: json['TCK_FEE2'],
      preOccDcFee: json['PRE_OCC_DC_FEE'],
      dcPsbYn: json['DC_PSB_YN'],
      jntDcFee: json['JNT_DC_FEE'],
      tckFee9: json['TCK_FEE9'],
      deprTimePrinYn: json['DEPR_TIME_PRIN_YN'],
      tckFee92: json['TCK_FEE92'],
      rndDcFee: json['RND_DC_FEE'],
      takeDrtm: json['TAKE_DRTM'],
    );
  }
}

class ibt_info_Seat {
  String number;
  String status;

  ibt_info_Seat({required this.number, required this.status});

  factory ibt_info_Seat.fromJson(Map<String, dynamic> json) {
    return ibt_info_Seat(
      number: json.keys.first,
      status: json.values.first,
    );
  }
}

class ibt_info_Lin {
  String linFrNam;
  String rotSqno;
  String linTo;
  String linFr;

  ibt_info_Lin({required this.linFrNam, required this.rotSqno, required this.linTo, required this.linFr});

  factory ibt_info_Lin.fromJson(Map<String, dynamic> json) {
    return ibt_info_Lin(
      linFrNam: json['LIN_FR_NAM'],
      rotSqno: json['ROT_SQNO'],
      linTo: json['LIN_TO'],
      linFr: json['LIN_FR'],
    );
  }
}

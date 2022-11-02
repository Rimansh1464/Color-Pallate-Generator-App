import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/pallate.dart';

class ColorProvider with ChangeNotifier {
  List<dynamic> color = [];
  List<int> colorList = [];

  PallateModal pallete = PallateModal(
    index: 0,
    PallateList: [],
  );

  void PallatreChange({required int index}) async {
    String json = await rootBundle.loadString("assets/json/color_data.json");
    List<dynamic> decodedData = jsonDecode(json);
     color = await decodedData[index]["pallate"];
    colorList = color.map((e) => int.parse(e, radix: 16)).toList();
    pallete.PallateList = colorList.map((e) => Color(e)).toList();
    notifyListeners();
  }
}

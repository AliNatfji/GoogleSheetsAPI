import 'package:google_sheets/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _creadentials = r'''
  {
  "type": "service_account",
  "project_id": "sheet-338019",
  "private_key_id": "3128ee88f8f31a8810d97a1879d84cb0dcbea9e4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCHaHb1h+K1+9MS\nUTG5aNtAsV0MX88M1Yg9tv1GO3+vSLMM4lPZcM+tttjdaPbLpPxNzRc9OHHojAQp\nIfLkuzeykdZkQrYWS/TvKU6iA7/sEXdqi6JI3h7spKGsXv6ZgDRaLrMyLwE/anPx\nGAIlwKbe+fCCEsCGER7f4b72UKIyhlxW80TdUqK79xBIsY9F6616936W9a27yvUa\n7TIMWJFW8AUNyeUjBXlI89i2+ypS3Oc8UXjBYr1iDZcWr/i7b/PQig44Y0FgeGgc\nEqPeL6A7L50iPwsGGFXBBy2GpuucLoAYjJgHu+84Qu7976qcOQgMGLNUdpGGzbMp\nB1ZR1dv/AgMBAAECggEAPGPSPjHy4f/kRHSSzSKfOkx/969ZK9ul7gRJFAQgL6Ao\nPrRH+h+Od+am9KRGAU/dOKOh3Ctq3fBoQKID7pAyyICzUbbQ98O7gth02dv7QgEO\nNaX95CqwNxE7i6E4QmSDtL7EK7r7/vjuqZVwC79OjP6CjbhoRcKn9uh63ubaV9af\njRVA72xVlXSVTeTmNIZjBCn1x/Q8P6sOmYloylru4iJbdbRusykIPlzDeiin0Tdr\ngtW2zW/+rWdJ2jT+X2VSRv7xlqiOPMWTZhqPeGLfc3G93qDi910Z19J9U3lxJ2Il\nhobYx29CEEpnw3yAiI3jUv6hZZzip3q4tggUCi5VMQKBgQC8jU26ottBqEylV45O\nwkVpLGDhE1A+4lBDsMeAgG3uMy6cqJc7ieRNolcpEhgjWnQZ0nPoST/7di1Ykqt8\nVScbf/phnTfD3lYvZUwuhlL95fsCZ4DYyko52pZNYmjLmInHSR5kqIeG8riSf8Wy\ncmoog7oe8yOlwrXyrEl/h/XGzwKBgQC32H5/mkmCr3CawDXkzctdCDEGapwU2gUG\nCyW0LRpfsHW7nmWPNTAVNBo2BfB+ZiXar1dFtGserhJFXE2Y8dirAzd5gxh+a7V/\n9qFF8BmzSENURtEMWKEFvL0J8BQhhbFIUoep3lpFSPudEzuI12HAS9f97pfGLyME\npO++qAvj0QKBgQC4JyorhrOuRLnXItSSh5tTRUy5hytwv4i1FAtFrimv4706tE5A\nkESyrkOCkXGR1d5e+fTKggBDkQBo6ZcjL+eqLCxW+j5kxtpWIBFvvzF/WQb3Ki/l\njG1CZAM4QU0ozCqEwR02IoN7gcRTEQf9aVHVkBJP+Bhw5OLfyPVf4WJicQKBgDJ+\nc7/4UFhkdzkJscO2AjT7Gvv4LAZOGzMdvK1P9f5yKOPvDVXX9ezc8pYD65nL1HnL\nztyGQSWcCcijIWzwf+H4cDQfnYqbaq5KvuDGoUhsgJGVIbWSYieBPyqLlfvfDGIg\nyMIPIBwHf5QUxDVBcseuDRThgy4bpDKSWoazAREBAoGAHR5efbxiWbQN0Ig6Qbbp\np7Gq18P7INQGRXgS57iM+nORKEKFVl62qxZBSUX/TysdvOCi4J2ASLy+dLVPMiG3\nhuE6HImoSzcxbYSuYFHzynSwDrQ9C5U7AHyIP4YC6sBaj13AywnCkh5bIKBvHn7/\nScPfwb+MgH1ucLFFMVNDGsE=\n-----END PRIVATE KEY-----\n",
  "client_email": "sheets@sheet-338019.iam.gserviceaccount.com",
  "client_id": "117290993739821332760",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sheets%40sheet-338019.iam.gserviceaccount.com"
}
 ''';

  static const _spreadSheetId = '1CCKnVAs8gz48n5bualnqhhLC6lB9A-oG9IbutlB4gdo';
  static final _gSheets = GSheets(_creadentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);
      _userSheet = await _getWorkSheet(spreadSheet, title: 'Users');
      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error :$e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();

    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }
}

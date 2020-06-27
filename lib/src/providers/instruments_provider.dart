import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:onlinestorecapp/src/models/instrument_model.dart';
import 'package:mime_type/mime_type.dart';


class InstrumentsProvider {
  final String _url = 'https://online-store-220991.firebaseio.com';

  Future<bool> createInstrument(InstrumentModel instrument) async {
    final url  = '$_url/instruments.json';
    final resp = await http.post(url, body: instrumentModelToJson(instrument));

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<bool> updateInstrument(InstrumentModel instrument) async {
    final url  = '$_url/instruments/${instrument.id}.json';
    final resp = await http.put(url, body: instrumentModelToJson(instrument));

    final decodedData = json.decode(resp.body);

    return true;
  }

  Future<List<InstrumentModel>> loadInstruments() async {
    final url  = '$_url/instruments.json';
    final resp = await http.get(url);
    final List<InstrumentModel> instruments = new List();
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if(decodedData == null) return [];

    decodedData.forEach( (key, value) {
      final insTemp = InstrumentModel.fromJson(value);
      insTemp.id = key;
      instruments.add(insTemp);
    });
    return instruments;
  }

  Future<int> deleteInstrument(String id) async {
    final url = '$_url/instruments/$id.json';
    final resp = await http.delete(url);

    return 1;
  }

  Future<String>  uploadImage(File image) async {
    final _url = Uri.parse('https://api.cloudinary.com/v1_1/diwnlzjar/image/upload?upload_preset=j64orqps');
    final mimeType = mime(image.path).split('/');
    final imageUploadReq = http.MultipartRequest('POST', _url);

    final file = await http.MultipartFile.fromPath(
        'file',
        image.path,
        contentType: MediaType(mimeType[0], mimeType[1])
    );
    imageUploadReq.files.add(file);
    
    final streamResponse = await imageUploadReq.send();
    final resp = await http.Response.fromStream(streamResponse);

    if( resp.statusCode != 200 && resp.statusCode != 201){
      print('Ocurrio un error');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
    //https://res.cloudinary.com/diwnlzjar/image/upload/v1593253337/nrdtqdk2xmgckjqhgw7o.jpg
  }
}
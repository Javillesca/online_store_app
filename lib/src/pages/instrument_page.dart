import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:onlinestorecapp/src/models/instrument_model.dart';
import 'package:onlinestorecapp/src/providers/instruments_provider.dart';
import 'package:onlinestorecapp/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final instrumentProvider = new InstrumentsProvider();

  InstrumentModel instrument = new InstrumentModel();
  bool _saved = false;
  File image;

  @override
  Widget build(BuildContext context) {

    final InstrumentModel instData = ModalRoute.of(context).settings.arguments;
    if(instData != null) {
      instrument = instData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('OnlineStore'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: ()=> _selectImage(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: ()=> _selectImage(ImageSource.camera),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showImage(),
                _textFormFieldInstrument(),
                _textFormFieldType(),
                _textFormFieldPrice(),
                _switchListTileAvailable(),
                _buttonCreate()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    if (instrument.urlImage != null) {
      return FadeInImage(
        image: NetworkImage(instrument.urlImage),
        placeholder: AssetImage('assets/disc.gif'),
        height: 300.0,
        width: double.infinity,
        fit: BoxFit.contain,
      );
    } else {
      if( image != null ){
        return Image.file(
          image,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  Widget _textFormFieldInstrument() {
    return TextFormField(
      initialValue: instrument.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Marca y modelo del instrumento'
      ),
      onSaved: (value) => instrument.title = value,
      validator: (value)
      {
        return (value.length < 3) ? 'Introduzca el instrumento' : null;
      },
    );
  }

  Widget _textFormFieldType() {
    return TextFormField(
      initialValue: instrument.type,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Tipo de instrumento',
         hintText: 'Guitarra'
      ),
      onSaved: (value) => instrument.type = value,
      validator: (value){
        return (value.length < 3) ? 'Introduzca el tipo de instrumento' : null;
      }
    );
  }

  Widget _textFormFieldPrice() {
    return TextFormField(
        initialValue: instrument.value.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
            labelText: 'Precio',
            hintText: '100.50'
        ),
        onSaved: (value) => instrument.value = double.parse(value),
        validator: (value) {
          return (utils.isNumber(value) == true) ? null : 'Introduzca solo numeros';
        }
     );
  }

  Widget _switchListTileAvailable() {
    return SwitchListTile(
      value: instrument.available,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() => instrument.available = value),
    );
  }

  Widget _buttonCreate () {
    return RaisedButton.icon(
        icon: Icon(Icons.save_alt),
        label: Text('Guardar'),
        onPressed: (_saved) ? null : _submit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        color: Colors.deepPurple,
        textColor: Colors.white,
    );
  }

  void _submit() async {
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() { _saved = true; });

    if(image != null ){
      instrument.urlImage = await instrumentProvider.uploadImage(image);
    }

    if(instrument.id == null) {
      await instrumentProvider.createInstrument(instrument);
    } else {
      await instrumentProvider.updateInstrument(instrument);
    }
      showSnackbar('Instrumento guardado correctamente');
      Navigator.pop(context);

  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500)
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _selectImage(ImageSource type) async {
    image = await ImagePicker.pickImage(
        source: type
    );

    if(image != null) {
      instrument.urlImage = null;
    }
    setState(() {});
  }
}

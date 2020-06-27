import 'package:flutter/material.dart';
import 'package:onlinestorecapp/src/blocs/provider.dart';
import 'package:onlinestorecapp/src/models/instrument_model.dart';
import 'package:onlinestorecapp/src/providers/instruments_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final instrumentsProv = new InstrumentsProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage')
      ),
      body: _loadListInstruments(),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Widget _loadListInstruments() {
      return FutureBuilder(
        future: instrumentsProv.loadInstruments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            final instruments = snapshot.data;
            return ListView.builder(
                itemCount: instruments.length,
                itemBuilder: (context, i) => _createInstrument(context, instruments[i])
            );
          } else {
            return Center( child: CircularProgressIndicator());
          }
        },
    );
  }

  Widget _createInstrument(BuildContext context, InstrumentModel instrument) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        instrumentsProv.deleteInstrument(instrument.id).then((value) =>  setState(() {}));
      },
      child: Card(
       child: Column(
         children: <Widget>[
           (instrument.urlImage == null )
            ? Image(image: AssetImage('assets/no-image.png'))
            : FadeInImage(
                image: NetworkImage(instrument.urlImage),
                placeholder: AssetImage('assets/disc.gif'),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.contain
            ),
            ListTile(
              title: Text('${ instrument.title } - ${ instrument.value }'),
              subtitle: Text(instrument.id),
              onTap: () => Navigator.pushNamed(context, 'product', arguments: instrument )
                  .then((value) => setState((){}))
            ),
         ],
       ),
      )
    );
  }

  _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product').then((value) => setState((){})),
    );
  }
}

import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Simple Interest Calculator',
      home: SIform(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
      ),
      ),
 );
}
 
  class SIform extends StatefulWidget{

    @override
    State<StatefulWidget> createState(){
      return _SIformState();
    }

  }
class _SIformState extends State<SIform>{

var currencies = ['Rupees', 'Dollars','Pounds'];
final double _minimumpadding= 3.0;
var _displayText = '';
var _currentItemSelected = 'Rupees';
var _formkey = GlobalKey<FormState>();

TextEditingController principleController = TextEditingController();
TextEditingController roiController = TextEditingController();
TextEditingController termController = TextEditingController();

@override
Widget build(BuildContext context)
{         
  
          TextStyle textStyle = Theme.of(context).textTheme.title;
          return Scaffold(
                          //resizeToAvoidBottomPadding: false,
                          appBar: AppBar(
                          title:  Text("Simple Interest Calculator"),
                         ),
                         body: Form(      key: _formkey,
                                          child: Padding( padding: EdgeInsets.all(_minimumpadding),
                                          
                                          child: ListView(
                                          children: <Widget>[
                                                   getImageAsset(),      
                                                   Padding(   padding: EdgeInsets.only(top: _minimumpadding , bottom: _minimumpadding),
                                                              child: TextFormField( keyboardType: TextInputType.number,
                                                              style: textStyle,
                                                              controller: principleController,
                                                              
                                                              validator: (String value){
                                                                if(value.isEmpty){
                                                                  return 'Please Enter Principal Amount';
                                                                }
                                                              },
                                                              decoration: InputDecoration(
                                                                          labelText: "Principal",
                                                                          labelStyle: textStyle,
                                                                          hintText: "Enter Principal Here",
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)
                                                                          
                                                                          ),
                                                                          errorStyle: TextStyle(
                                                                            color : Colors.yellowAccent,
                                                                            fontSize: 15.0,
                                                                          ),
                                                                          ),
                                                                          )  )   ,
                                                                          
                                                  Padding(    padding: EdgeInsets.only(top: _minimumpadding,bottom: _minimumpadding),
                                                              child: TextFormField( keyboardType: TextInputType.number,
                                                              controller: roiController,
                                                              validator: (String value){
                                                                if(value.isEmpty){
                                                                  return 'Please enter Rate of Interest';
                                                                }
                                                              },
                                                              decoration: InputDecoration(
                                                                          labelText: "Rate of Interest",
                                                                          labelStyle: textStyle,
                                                                          hintText: "Enter Rate Here",
                                                                          errorStyle: TextStyle(
                                                                            color: Colors.yellowAccent,
                                                                            fontSize: 15.0,
                                                                          ),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)
                                                                          ),
                                                                          ),
                                                                          )),        
                                                  Padding(
                                                          padding: EdgeInsets.only(top: _minimumpadding,bottom: _minimumpadding),
                                                          child: Row(children: <Widget>[
                                                             Expanded(child: TextFormField( keyboardType: TextInputType.number,
                                                              controller: termController,
                                                              validator: (String value){
                                                                if(value.isEmpty){
                                                                  return 'Please enter time period';
                                                                }
                                                              },
                                                              decoration: InputDecoration(
                                                                          
                                                                          labelText: "Term",
                                                                          labelStyle: textStyle,
                                                                          hintText: "Time in years",
                                                                          errorStyle: TextStyle(
                                                                            fontSize: 15.0,
                                                                            color: Colors.yellowAccent
                                                                            ),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)
                                                                          ),
                                                                          ),
                                                                          ),
                                                                          ),
                                                              Container(width: _minimumpadding,),
                                                              Expanded(child: DropdownButton<String>(
                                                                items: currencies.map((String value){
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),);
                                                                },).toList(),
                                                                value: 'Rupees',
                                                                onChanged: (String newValueSelected){
                                                                            _onDropDownItemSelected(newValueSelected);
                                                                },
                                                                )
                                                                )
                                                  ],
                                                  )
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: _minimumpadding,bottom: _minimumpadding),
                                                    child:Row(children: <Widget>[
                                                      Expanded(
                                                        child: RaisedButton(
                                                                child: Text('Calculate' , style:  textStyle,),
                                                                onPressed: (){
                                                                  
                                                                  setState(() {
                                                                  if(_formkey.currentState.validate()){
                                                                   this._displayText = _calculateTotalReturns(); 
                                                                  }});  
                                                                    
                                                                },),
                                                                ),
                                                      Expanded(
                                                        child: RaisedButton(
                                                                child: Text('Reset',textScaleFactor: 1.5 ),
                                                                color: Theme.of(context).primaryColorDark,
                                                                textColor: Theme.of(context).primaryColorLight,
                                                                onPressed: (){
                                                                         setState(() {
                                                                          _reset(); 
                                                                         });
                                                                },),
                                                                )
                                                  ],
                                                  ),
                                                  ),
                                                  
                                                  Padding(padding: EdgeInsets.only(bottom: _minimumpadding,top: _minimumpadding),
                                                          child: Text(this._displayText,style: textStyle),
                                                  
                                                  ),
                                                  ],

                                          ),
                                          ),
                                          ),
            );
}
   Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/S.png');
  Image image = Image(image: assetImage,width: 150.0,height: 150.0,);
  return Container(child: image,margin: EdgeInsets.all(_minimumpadding*5),);
  }      
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
     this._currentItemSelected = newValueSelected; 
    });
    
    

  }   

  String _calculateTotalReturns(){
      double principal = double.parse(principleController.text);
      double roi = double.parse(roiController.text);
      double term = double.parse(termController.text);

      double totalAmountPayable = principal + (principal * roi * term) / 100;

      String result = 'After $term years , your investment will be worth $totalAmountPayable $_currentItemSelected';
      return result;
  }
 void _reset(){
      principleController.text ='';
      roiController.text='';
      termController.text='';
      _displayText='';
      _currentItemSelected=currencies[0];
    }
}
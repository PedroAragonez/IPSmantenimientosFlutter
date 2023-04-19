import 'dart:convert';

import 'package:i_p_s_mant/appointment_details/appointment_details_widget.dart';
import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/catClientes.dart';
import 'package:i_p_s_mant/models/catEmpresa.dart';
import 'package:i_p_s_mant/models/catEquipo.dart';
import 'package:i_p_s_mant/models/catMarca.dart';
import 'package:i_p_s_mant/models/catModelo.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BookAppointmentWidget extends StatefulWidget {
  final colaborador usuario ;
  const BookAppointmentWidget({
    Key key,this.usuario
  }) : super(key: key);


  @override
  _BookAppointmentWidgetState createState() => _BookAppointmentWidgetState();
}

class _BookAppointmentWidgetState extends State<BookAppointmentWidget>
    with TickerProviderStateMixin {
  List<catEmpresa> empresas;
  List<catCliente> clientes;
  List<book> listaBook = [];
  SharedPreferences  preffs;

  int identificador = 0;
  Location currentLocation = Location();
  String dropDownValue;
  String personsNameController;
  String clientNameController;
  String tipoEquipoController;
  String marcaController;
  TextEditingController problemDescriptionController;
  TextEditingController serialNumberController;
  String modeloController;
  String accesoriosController = "NA";
  requisitorEvento appointmentDetails;
  String iLatitud;
  String iLongitud;
  final animationsMap = {
    'textFieldOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 9),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'dropDownOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 40,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 20),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'textFieldOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 60,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 30),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 90),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'buttonOnPageLoadAnimation1': AnimationInfo(
      curve: Curves.bounceOut,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 150,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 20),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
    'buttonOnPageLoadAnimation2': AnimationInfo(
      curve: Curves.bounceOut,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 150,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 20),
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    _getLocation();
    _getEmpresas();
    problemDescriptionController = TextEditingController();
    serialNumberController = TextEditingController();
  }

  _getRequisitorEventos(){
    DatabaseProvider.getEstatusDetalleEventoByAsesor(widget.usuario.usuario).then((value) {

      final element = value.last;
      DatabaseProvider.getDetalleEventoById(element.id.toString()).then((detalle){
        DatabaseProvider.getRequisitorEventoById(detalle.idEvento.toString()).then((requisitor) {
          setState(() async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AppointmentDetailsWidget(
                      usuario: widget.usuario,
                      appointmentDetails:
                      requisitor,
                    ),
              ),
            );

          });
        });

      });
    });

  }

  _getEmpresas(){
    DatabaseProvider.getCatEmpresas().then((value) {
      setState(() {
        empresas = value;
      });
    });
  }

  _getClientsbyEmpresa(){
    DatabaseProvider.getCatEmpresasByNombre(personsNameController).then((value) {
      DatabaseProvider.getCatClientesByIDEmpresa(value.id.toString()).then((clientesresult) {
        setState(() {
          clientes = clientesresult;
        });
      });
    });
  }
  static List<book> parseBook(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<book>((json) => book.fromJson(json)).toList();
  }
  _insertarTicket() async {
    preffs = await SharedPreferences.getInstance();
    book ultim = book();
    ultim.empresa = clientNameController;
    ultim.cliente = personsNameController;
    ultim.tipo = dropDownValue;
    String temp = preffs.getString("listaBook");
    print(temp);
    int estauts = 0;

    if(temp!=null){
      List<book> temporalBook = parseBook(temp);
      temporalBook.forEach((element) {
        if(element.empresa==ultim.empresa){
          if(element.cliente==ultim.cliente){
            estauts = 1;
          }else{
            print("la empresa se ah utilizado");
          }

        }
      });
    }


    if(estauts==0){
      listaBook.add(ultim);
      final x =  jsonEncode(listaBook);
      print(x);
      preffs.setString("listaBook", x);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AppointmentDetailsWidget(
                usuario: widget.usuario,
                booK: ultim,
              ),
        ),
      );
    }else{
      listaBook = book.decode(temp);
      final index = listaBook.indexWhere((element) =>
      element.cliente == ultim.cliente && element.empresa == ultim.empresa);
      print(index);
      if (index!=0) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlertDialog(
              title: const Text('YA ESTAS OPERANDO CON ESTE CLIENTE'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('VUELVE A VISITAS PARA CONTINUAR'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }else{
        listaBook.add(ultim);
        String x =  jsonEncode(listaBook);
        print(x);
        preffs.setString("listaBook", x);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AppointmentDetailsWidget(
                  usuario: widget.usuario,
                  booK: ultim,
                ),
          ),
        );
      }
    }



  }
  _getLocation() async {
    var location = await currentLocation.getLocation();

    setState(() {
      iLatitud = location.latitude.toString();
      iLongitud = location.longitude.toString();
      identificador = 1;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).darkBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 3,
                indent: 150,
                endIndent: 150,
                color: Color(0xFF465056),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  'Nuevo servicio',
                  style: FlutterFlowTheme.of(context).title3,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Inicia el proceso de servicio.',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Text(
                  'Estas operando como:',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                child: Text(
                  widget.usuario.nombre,
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              ),
              empresas!=null ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: FlutterFlowDropDown(
                  options: new List.generate(empresas.length, (index) => empresas[index].nombre),
                  onChanged: (val) {setState(() {personsNameController = val;
                  _getClientsbyEmpresa();});}
                  ,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  textStyle:
                  FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                  ),
                  hintText: 'Empresa',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).grayLight,
                    size: 15,
                  ),
                  fillColor: FlutterFlowTheme.of(context).darkBackground,
                  elevation: 3,
                  borderColor: FlutterFlowTheme.of(context).background,
                  borderWidth: 2,
                  borderRadius: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
                  hidesUnderline: true,
                ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              ) : Column(),

              clientes!=null ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: FlutterFlowDropDown(
                  options:  new List.generate(clientes.length, (index) => clientes[index].nombre),
                  onChanged: (val) => setState(() => clientNameController = val),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  textStyle:
                  FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                  ),
                  hintText: 'Seleccione un cliente',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).grayLight,
                    size: 15,
                  ),
                  fillColor: FlutterFlowTheme.of(context).darkBackground,
                  elevation: 3,
                  borderColor: FlutterFlowTheme.of(context).background,
                  borderWidth: 2,
                  borderRadius: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
                  hidesUnderline: true,
                ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              ) : Column(),


              clientNameController!=null ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: FlutterFlowDropDown(
                  options: [
                    'MANTENIMIENTOENCAMPO',
                    'SOPORTEENCAMPO'
                  ].toList(),
                  onChanged: (val) => setState(() => dropDownValue = val),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  textStyle:
                  FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                  ),
                  hintText: 'Tipo de servicio',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).grayLight,
                    size: 15,
                  ),
                  fillColor: FlutterFlowTheme.of(context).darkBackground,
                  elevation: 3,
                  borderColor: FlutterFlowTheme.of(context).background,
                  borderWidth: 2,
                  borderRadius: 8,
                  margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
                  hidesUnderline: true,
                ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              ) : Column(),

              // clientNameController!=null ?  Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: FlutterFlowDropDown(
              //     options:  new List.generate(tipoEquipos.length, (index) => tipoEquipos[index].nombre),
              //     onChanged: (val) => setState(() => tipoEquipoController = val),
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 60,
              //     textStyle:
              //     FlutterFlowTheme.of(context).subtitle2.override(
              //       fontFamily: 'Lexend Deca',
              //       color: FlutterFlowTheme.of(context).textColor,
              //     ),
              //     hintText: 'Seleccione tipo de equipo',
              //     icon: Icon(
              //       Icons.keyboard_arrow_down_rounded,
              //       color: FlutterFlowTheme.of(context).grayLight,
              //       size: 15,
              //     ),
              //     fillColor: FlutterFlowTheme.of(context).darkBackground,
              //     elevation: 3,
              //     borderColor: FlutterFlowTheme.of(context).background,
              //     borderWidth: 2,
              //     borderRadius: 8,
              //     margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
              //     hidesUnderline: true,
              //   ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              // ): Column(),
              // clientNameController!=null ? Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: FlutterFlowDropDown(
              //     options:  new List.generate(marcas.length, (index) => marcas[index].marca),
              //     onChanged: (val) => setState(() {
              //     _getModelo(val);}),
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 60,
              //     textStyle:
              //     FlutterFlowTheme.of(context).subtitle2.override(
              //       fontFamily: 'Lexend Deca',
              //       color: FlutterFlowTheme.of(context).textColor,
              //     ),
              //     hintText: 'Seleccione una marca',
              //     icon: Icon(
              //       Icons.keyboard_arrow_down_rounded,
              //       color: FlutterFlowTheme.of(context).grayLight,
              //       size: 15,
              //     ),
              //     fillColor: FlutterFlowTheme.of(context).darkBackground,
              //     elevation: 3,
              //     borderColor: FlutterFlowTheme.of(context).background,
              //     borderWidth: 2,
              //     borderRadius: 8,
              //     margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
              //     hidesUnderline: true,
              //   ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              // ) : Column(),
              // modelo!=null ? Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: FlutterFlowDropDown(
              //     options:  new List.generate(modelo.length, (index) => modelo[index].modelo),
              //     onChanged: (val) => setState(() => modeloController = val),
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 60,
              //     textStyle:
              //     FlutterFlowTheme.of(context).subtitle2.override(
              //       fontFamily: 'Lexend Deca',
              //       color: FlutterFlowTheme.of(context).textColor,
              //     ),
              //     hintText: 'Seleccione un modelo',
              //     icon: Icon(
              //       Icons.keyboard_arrow_down_rounded,
              //       color: FlutterFlowTheme.of(context).grayLight,
              //       size: 15,
              //     ),
              //     fillColor: FlutterFlowTheme.of(context).darkBackground,
              //     elevation: 3,
              //     borderColor: FlutterFlowTheme.of(context).background,
              //     borderWidth: 2,
              //     borderRadius: 8,
              //     margin: EdgeInsetsDirectional.fromSTEB(20, 4, 16, 4),
              //     hidesUnderline: true,
              //   ).animated([animationsMap['dropDownOnPageLoadAnimation']]),
              // ) : Column(),

              // clientNameController!=null ? Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              //   child: TextFormField(
              //     controller: serialNumberController,
              //     textCapitalization: TextCapitalization.characters,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       labelText: 'Numero de Serie',
              //       labelStyle: FlutterFlowTheme.of(context).bodyText1,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterFlowTheme.of(context).background,
              //           width: 2,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterFlowTheme.of(context).background,
              //           width: 2,
              //         ),
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       filled: true,
              //       fillColor: FlutterFlowTheme.of(context).darkBackground,
              //       contentPadding:
              //       EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
              //     ),
              //     style: FlutterFlowTheme.of(context).subtitle2.override(
              //       fontFamily: 'Lexend Deca',
              //       color: FlutterFlowTheme.of(context).textColor,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ).animated(
              //       [animationsMap['textFieldOnPageLoadAnimation1']]),
              // ) : Column(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Cancelar',
                      options: FFButtonOptions(
                        width: 100,
                        height: 50,
                        color: FlutterFlowTheme.of(context).background,
                        textStyle:
                        FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    ).animated(
                        [animationsMap['buttonOnPageLoadAnimation1']]),
                    clientNameController!=null ? FFButtonWidget(
                      onPressed: () async {
                        _insertarTicket();
                        // _getRequisitorEventos();
                      },
                      text: 'Iniciar',
                      options: FFButtonOptions(
                        width: 150,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                        FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    ).animated(
                        [animationsMap['buttonOnPageLoadAnimation2']]) : Column(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
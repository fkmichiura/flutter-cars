import 'package:carros_app/domain/carro.dart';import 'package:carros_app/utils/prefs.dart';import 'package:carros_app/widgets/carros_list.dart';import 'package:flutter/material.dart';class HomePage extends StatefulWidget {  @override  _HomePageState createState() => _HomePageState();}class _HomePageState extends State<HomePage>    with SingleTickerProviderStateMixin<HomePage> {  TabController tabController;  @override  void initState() {    super.initState();    tabController = TabController(length: 3, vsync: this);    Prefs.getInt("tabIndex").then((index) {      tabController.index = index;    });    tabController.addListener(() async {      Prefs.setInt("tabIndex", tabController.index);    });  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        title: Text("Main"),        bottom: TabBar(controller: tabController, tabs: [          Tab(            text: "Clássicos",            icon: Icon(Icons.directions_car),          ),          Tab(            text: "Esportivos",            icon: Icon(Icons.directions_car),          ),          Tab(            text: "Luxo",            icon: Icon(Icons.directions_car),          ),        ]),      ),      body: TabBarView(controller: tabController, children: [        CarrosListView(TipoCarro.classicos),        CarrosListView(TipoCarro.esportivos),        CarrosListView(TipoCarro.luxo),      ]),    );  }}
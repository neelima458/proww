import 'package:flutter/material.dart';
import 'dart:math';

class OptionChainTable extends StatefulWidget {
  @override
  _OptionChainTableState createState() => _OptionChainTableState();
}

class _OptionChainTableState extends State<OptionChainTable> {
  final ScrollController _callSideController = ScrollController();
  final ScrollController _putSideController = ScrollController();

  // Generate example data for 14 data points
  final List<Map<String, double>> optionChainData = List.generate(10, (index) => generateRandomData());

  @override
  void initState() {
    super.initState();

    // Synchronize scrolling with smooth animation
    _callSideController.addListener(() {
      if (!_putSideController.hasClients) return;
      _putSideController.animateTo(
        _callSideController.offset,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeIn,
      );
    });

    _putSideController.addListener(() {
      if (!_callSideController.hasClients) return;
      _callSideController.animateTo(
        _putSideController.offset,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _callSideController.dispose();
    _putSideController.dispose();
    super.dispose();
  }

  static int i = 0;
  // Function to generate random data for each row
  static Map<String, double> generateRandomData() {
    Random random = Random();
    return {
      'Strike': 15000.0 + ((i++) * 100), // Strike price in range 15000 to 15900
      'LTP': 100.0 + random.nextDouble() * 50,
      'OI(lakhs)': random.nextDouble() * 50,
      'OI(chg)': random.nextDouble() * 10,
      'Delta': random.nextDouble() * 1,
      'Theta': random.nextDouble() * 1,
      'Gamma': random.nextDouble() * 0.1,
      'Vega': random.nextDouble() * 0.5,
      'IV': 10.0 + random.nextDouble() * 20,
      'Volume': 1000.0 + random.nextDouble() * 5000,
      'Margin': 10000.0 + random.nextDouble() * 10000,
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, double>> reversedOptionChainData = List.from(optionChainData.reversed);
    List<String> reversedHeaders = [
      'Margin', 'Volume', 'IV', 'Vega', 'Gamma', 'Theta', 'Delta', 'OI(chg)', 'OI(lakhs)', 'LTP'
    ];

    return Scaffold(
      backgroundColor:Color.fromARGB(255, 229, 247, 235),
      body: Column(
        children: [
      Container(
        alignment: Alignment.center,
      decoration: BoxDecoration(
      color: Color.fromARGB(255, 229, 247, 235),
    ),
    height: 100,
    child: Text("O P T I O N S",style: TextStyle(color: Colors.green, fontSize: 35, fontWeight: FontWeight.bold),),
    width: double.infinity,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calls',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Puts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Table
          Expanded(
            child: Row(
              children: [
                // Call Side
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _callSideController,
                    child: Container(
                      color: Colors.lightGreen[200], // Set the background color here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildColumnHeader(reversedHeaders),
                          ...List.generate(reversedOptionChainData.length, (index) {
                            return Row(
                              children: reversedHeaders.map((header) {
                                return _buildCell('${reversedOptionChainData[index][header]!.toStringAsFixed(2)}');
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                // Strike Price Column
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      _buildColumnHeader(['Strike']),
                      ...List.generate(reversedOptionChainData.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('${reversedOptionChainData[index]['Strike']!.toStringAsFixed(2)}'),
                        );
                      }),
                    ],
                  ),
                ),
                // Put Side
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    controller: _putSideController,
                    child: Container(
                      color: Colors.red[100], // Set the background color here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildColumnHeader(['LTP', 'OI(lakhs)', 'OI(chg)', 'Delta', 'Theta', 'Gamma', 'Vega', 'IV', 'Volume', 'Margin']),
                          ...List.generate(optionChainData.length, (index) {
                            return Row(
                              children: optionChainData[index].entries
                                  .where((entry) => entry.key != 'Strike')
                                  .map((entry) => _buildCell('${entry.value.toStringAsFixed(2)}'))
                                  .toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(String text) {
    return Container(
      width: 80.0,
      height: 50.0,
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(text),
    );
  }

  Widget _buildColumnHeader(List<String> headers) {
    return Row(
      children: headers.map((header) => _buildHeaderCell(header)).toList(),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      width: 80.0,
      height: 50.0,
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}


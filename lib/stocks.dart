
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockPricesPage extends StatefulWidget {
  @override
  _StockPricesPageState createState() => _StockPricesPageState();
}

class _StockPricesPageState extends State<StockPricesPage> {
  List<dynamic> stockData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    final url = Uri.parse('https://saifaismart-vaibhav350-bd1d5c7f.koyeb.app/api/products/get');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        stockData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load data'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(

        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: stockData.length,
          itemBuilder: (context, index) {
            final stock = stockData[index];
            return ListTile(
              title: Text(stock['name']),
              trailing: Text('\$${stock['price']}', style: TextStyle(color: Colors.green),),
            );
          },
        ),
      ),
    );
  }
}

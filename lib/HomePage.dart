import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Variables to store the Bitcoin prices
  String usdPrice = '';
  String gbpPrice = '';
  String eurPrice = '';
  List<dynamic> stockData = [];
  bool isLoadingStockData = true;

  // Function to fetch the Bitcoin prices
  Future<void> fetchBitcoinPrices() async {
    final response = await http.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        usdPrice = data['bpi']['USD']['rate'];
        gbpPrice = data['bpi']['GBP']['rate'];
        eurPrice = data['bpi']['EUR']['rate'];
      });
    } else {
      throw Exception('Failed to load Bitcoin prices');
    }
  }

  // Function to fetch stock prices
  Future<void> fetchStockData() async {
    final url = Uri.parse('https://saifaismart-vaibhav350-bd1d5c7f.koyeb.app/api/products/get');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        stockData = json.decode(response.body);
        isLoadingStockData = false;
      });
    } else {
      setState(() {
        isLoadingStockData = false;
      });
      // Handle error here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load stock data'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBitcoinPrices();
    fetchStockData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 247, 235),
            ),
            height: 200,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/Stocks.jpeg",
                          height: 70,
                        ),
                      ),
                      Text(
                        "Proww  ",
                        style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bitcoin: USD', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('$usdPrice ',style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bitcoin: GBP', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('$gbpPrice',style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bitcoin: EUR', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('$eurPrice ',style: TextStyle(color: Colors.green)),
                              ],
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoadingStockData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: stockData.length,
              itemBuilder: (context, index) {
                final stock = stockData[index];
                return ListTile(
                  title: Text(stock['name']),
                  trailing: Text('\$${stock['price']}', style: TextStyle(color: Colors.green)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

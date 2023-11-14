import 'package:flutter/material.dart';
import 'package:shopping_inventory/screens/shoplist_item.dart';
import 'package:shopping_inventory/widgets/left_drawer.dart';
import 'package:shopping_inventory/widgets/shop_card.dart';
import 'package:shopping_inventory/screens/shoplist_form.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);
    final List<ShopItem> items = [
      ShopItem("Lihat Produk", Icons.checklist, Colors.red),
      ShopItem("Tambah Produk", Icons.add_shopping_cart, Colors.yellow),
      ShopItem("Logout", Icons.logout, Colors.green),
    ];
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shopping Inventory',
          ),
         backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Shop Inventory', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((ShopItem item) {
                    // Iterasi untuk setiap item
                    return ShopCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

           // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Produk") {
            // Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopFormPage()),
            );
          }
          if (item.name == "Lihat Produk") {
            // Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopItemPage()),
            );
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:task_6/add_product_page.dart';
import 'package:task_6/product_card.dart';
import 'package:task_6/search_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const UserInfo(),
        actions: const [NotificationButton()],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Color.fromRGBO(63, 81, 243, 1),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: const Column(
        children: [
          SearchComponent(),
          Expanded(
            child: ListProduct(),
          ),
        ],
      ),
    );
  }
}

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Row(
        children: [
          const Text('Available Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SearchProduct()));
            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey.shade400)),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.grey.shade400,
                )),
          ),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade400),
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('July 14, 2023',
                style: TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            Row(
              children: [
                Text(
                  'Hello',
                  style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                Text('Yohannes',
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 15,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ],
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.grey.shade400)),
          child: IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          )),
    );
  }
}

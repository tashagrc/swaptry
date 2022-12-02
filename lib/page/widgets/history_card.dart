import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swaptry/models/history.dart';
import 'package:swaptry/page/history_detail_page.dart';
import 'package:swaptry/page/widgets/appTheme.dart';

class HistoryCard extends StatelessWidget {
  final History history;
  const HistoryCard(this.history,{super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(
          context, MaterialPageRoute(builder: (_) => HistoryDetailPage(history)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 82, height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xffBAFF99)
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: textStyle(10, medium, darkerGrey),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.history_rounded, color: darkGrey),
              const SizedBox(width: 5),
              Text(
                DateFormat.yMMMMd().add_jm().format(history.date),
                style: textStyle(13, medium, greyText),
              ),
            ],
          ),
          Text(
            history.name,
            style: textStyle(16, medium, darkerGrey),
          ),
          Text(
            'Order ID: ${history.orderId}',
            style: textStyle(11, regular, greyText),
          ),
          const SizedBox(height: 5),
          
          Text(
            NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 2
            ).format(history.price),
            style: textStyle(15, medium, black),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: const Color(0xffBBBBBB),
          )
        ],
      ),
    );
  }
}
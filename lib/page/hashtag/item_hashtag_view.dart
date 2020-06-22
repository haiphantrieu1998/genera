import 'package:flutter/material.dart';
import 'package:geneexpert/base/utils.dart';
import 'package:geneexpert/page/hashtag/menu_hashtag_model.dart';
import 'package:geneexpert/utils/text_styles.dart';

import 'detail/hashtag_detail_page.dart';
class ItemHashtagView extends StatelessWidget {
  final MenuHashtagModel model; //todo: dữ liệu được truyền sang qua model
  const ItemHashtagView({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String image = 'assets/images/${model.id}.png';
    String name = model.name;
    return GestureDetector(
      onTap: () => _onDetail(context),
      child: Container(
        width: double.infinity,
        height: 80,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 35,
          ),
          child: Text(
            name,
            style: TextStyles.subscriptionTextStyle,
          ),
        ),
      ),
    );
  }

  void _onDetail(BuildContext context) {
    Utils.navigator(
        context,
        HashtagDetailPage( //todo: truyền dữ liệu sang trang detail
          model: model,
        ));
  }
}

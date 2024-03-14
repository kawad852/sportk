import 'package:flutter/material.dart';
import 'package:sportk/model/faq_model.dart';
import 'package:sportk/network/api_service.dart';
import 'package:sportk/network/api_url.dart';
import 'package:sportk/utils/base_extensions.dart';
import 'package:sportk/widgets/custom_expansion_tile.dart';
import 'package:sportk/widgets/custom_future_builder.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late Future<FaqModel> _faqFuture;

  void _initFuture() {
    _faqFuture = ApiService<FaqModel>().build(
      weCanUrl: ApiUrl.faq,
      isPublic: true,
      apiType: ApiType.get,
      builder: FaqModel.fromJson,
    );
  }

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalization.faq),
      ),
      body: CustomFutureBuilder(
        future: _faqFuture,
        onRetry: () {
          setState(() {
            _initFuture();
          });
        },
        onComplete: (context, snapshot) {
          return ListView.separated(
            itemCount: snapshot.data!.data!.length,
            padding: const EdgeInsets.all(20),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final faq = snapshot.data!.data![index];
              return CustomExpansionTile(
                title: faq.question!,
                child: Text(faq.answer!),
              );
            },
          );
        },
      ),
    );
  }
}

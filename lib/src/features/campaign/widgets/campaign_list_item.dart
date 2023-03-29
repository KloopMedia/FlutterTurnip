import 'package:flutter/material.dart';

class CampaignListItem extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final void Function()? onTap;

  const CampaignListItem({
    Key? key,
    required this.tag,
    required this.title,
    this.description,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Chip(
                            backgroundColor: Colors.grey[200],
                            visualDensity: VisualDensity.compact,
                            label: Text(
                              tag,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Text(title, style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (description != null)
                  Text(description!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

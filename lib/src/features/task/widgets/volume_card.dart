import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

import '../../../widgets/card/addons/card_chip.dart';

class VolumeCard extends StatelessWidget {
  final String name;
  final String description;
  final bool isSelected;
  final int index;
  final void Function() onTap;

  const VolumeCard({
    super.key,
    required this.name,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final chipOrder = index > 9
        ? "${context.loc.volume} $index"
        : "${context.orderLabel(index)} ${context.loc.volume.toLowerCase()}";

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 238,
        height: 141,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFECF0FF) : const Color(0xFFEFF1F1),
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardChip(
              isSelected ? context.loc.in_progress : chipOrder,
              backgroundColor: isSelected ? const Color(0xFF5E81FB) : Colors.white,
              fontColor: isSelected ? Colors.white : null,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: "Inter",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: "Inter",
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

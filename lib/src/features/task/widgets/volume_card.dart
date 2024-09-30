import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip_repository/gigaturnip_repository.dart';

import '../../../widgets/card/addons/card_chip.dart';

class VolumeCard extends StatelessWidget {
  final String name;
  final String description;
  final bool isSelected;
  final int index;
  final VolumeStatus status;
  final void Function() onTap;

  const VolumeCard({
    super.key,
    required this.name,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.index,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final chipOrder = index > 9
        ? "${context.loc.volume} $index"
        : "${context.orderLabel(index)} ${context.loc.volume.toLowerCase()}";

    return InkWell(
      onTap: status == VolumeStatus.locked ? null : onTap,
      child: Container(
        width: 238,
        height: 141,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: switch (status) {
            VolumeStatus.complete => const Color(0xFFDBF1C8),
            VolumeStatus.locked => const Color(0xFFEFF1F1),
            VolumeStatus.current => const Color(0xFFECF0FF),
          },
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            switch (status) {
              VolumeStatus.locked => CardChip(
                context.loc.closed,
                backgroundColor: const Color(0xFFFFCFC9),
              ),
              VolumeStatus.complete => CardChip(
                context.loc.complete,
                backgroundColor: const Color(0xFF98F072),
              ),
              VolumeStatus.current => CardChip(
                context.loc.in_progress,
                backgroundColor: const Color(0xFF5E81FB),
                fontColor: Colors.white,
              ),
            },
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

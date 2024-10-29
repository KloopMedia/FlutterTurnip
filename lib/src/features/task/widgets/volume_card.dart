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
    return InkWell(
      onTap: status == VolumeStatus.locked ? null : onTap,
      borderRadius: BorderRadius.circular(15),
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
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(width: 2, color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            switch (status) {
              VolumeStatus.locked => CardChip(
                  context.loc.closed_volume,
                  backgroundColor: const Color(0xFFFFCFC9),
                ),
              VolumeStatus.complete => CardChip(
                  context.loc.complete_volume,
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

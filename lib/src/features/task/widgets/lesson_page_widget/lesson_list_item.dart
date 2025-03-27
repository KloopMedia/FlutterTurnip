import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';

class LessonListItem extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback onTap;
  final bool isComplete;
  final bool isActive;

  const LessonListItem({
    super.key,
    required this.title,
    this.description,
    required this.onTap,
    required this.isComplete,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: isComplete || isActive ? onTap : null,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isActive ? Color(0xFFDCE1FF) : Color(0xFFEFF1F1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      color: !isComplete && !isActive ? Color(0xFF747878) : null,
                    ),
                  ),
                  if (description != null && description!.isNotEmpty)
                    Text(
                      description ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.outline,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            if (isComplete || isActive) const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:gigaturnip/src/widgets/card/card_with_chip_and_title.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/widgets.dart';

class ArticleChainRankTaskDetailView extends StatefulWidget {
  const ArticleChainRankTaskDetailView({Key? key}) : super(key: key);

  @override
  State<ArticleChainRankTaskDetailView> createState() => _ArticleChainRankTaskDetailViewState();
}

class _ArticleChainRankTaskDetailViewState extends State<ArticleChainRankTaskDetailView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Написать статью на свободную тему',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Место для описания задания В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци.Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме. Место для описания задания. В данном задании вам предлагается написать статью на выбранную тему. Статьи являются важным средством передачи информаци.Ваша задача состоит в том, чтобы создать информативную и увлекательную статью, которая заинтересует читателей и передаст ключевую информацию о выбранной теме.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: theme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Статус задания',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.neutral40,
          ),
        ),
        const SizedBox(height: 20),
        ///RankTaskCard
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 14,
                  height: 14,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,//theme.primary
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.primary,//neutral80
                    shape: BoxShape.rectangle,
                  ),
                  child: const Text(''),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Прочитать текст и заполнить недостающие буквы',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: theme.neutral40,
                    ),
                    softWrap: true,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                          'Начато: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: theme.neutral60
                          )
                      ),
                      Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: theme.primary
                          )
                      ),
                      const SizedBox(width: 8),
                      Text(
                          'Закончено: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: theme.neutral60
                          )
                      ),
                      Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: theme.primary
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Выполнить',//'Выполнить ещё'
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.primary
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: theme.primary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: theme.neutral90)
                ],
              ),
            ),
          ],
        ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: SizedBox(
            width: double.infinity,
            height: 52.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Взять на выполнение',
                style: TextStyle(
                  color: theme.isLight ? theme.onPrimary : theme.neutral0,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes/routes.dart';
import '../../../widgets/app_bar/default_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.goNamed(CampaignRoute.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inputDecoration = InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: colorScheme.isLight ? Colors.black : colorScheme.neutral60,
        ),
      ),
    );
    final lightTheme = Theme.of(context).copyWith(inputDecorationTheme: inputDecoration);
    final darkTheme = Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      ),
      inputDecorationTheme: inputDecoration,
    );

    return Theme(
      data: colorScheme.isLight ? lightTheme : darkTheme,
      child: DefaultAppBar(
        automaticallyImplyLeading: false,
        leading: [BackButton(onPressed: () => goBack(context))],
        title: Text(context.loc.privacy_policy),
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            if (context.isSmall) {
              return const _Content();
            } else {
              return Container(
                decoration: context.isSmall || context.isMedium
                    ? null
                    : BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: Shadows.elevation3,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(
                  vertical: context.isSmall || context.isMedium ? 0 : 40,
                  horizontal: context.isSmall || context.isMedium
                      ? 0
                      : MediaQuery.of(context).size.width / 5,
                ),
                child: const _Content(),
              );
            }
          }),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
    );


    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'ПОЛИТИКА КОНФИДЕНЦИАЛЬНОСТИ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              Text(
                'По состоянию 5 сентября 2022 г.',
                style: textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Настоящая Политика конфиденциальности персональных данных (далее – «Политика конфиденциальности») действует в отношении всей информации, который мобильное приложение «Репка», может получить о Пользователе во время использования.',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            '1. ОПРЕДЕЛЕНИЕ ТЕРМИНОВ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '1.1. В настоящей Политике конфиденциальности используются следующие значения:',
            style: textStyle
          ),
          const _TextWithBoldTitle(
            title: 'Администрация',
            text: ' – Общественный фонд «Клооп Медиа» зарегистрированный в Кыргызской Республике, создавший мобильное приложение, осуществляющее администрирование и техническую поддержку его работы, и предоставляющее Пользователям услуги посредством данного мобильного приложения.',
          ),
          const _TextWithBoldTitle(
            title: 'Мобильное приложение',
            text: '  – это программное обеспечение, предназначенное для использования на смартфонах, планшетах и других мобильных устройствах, созданное и функционирующее как сервис, обеспечивающий деятельность большого количества пользователей путем создания и заполнения цепочек форм.',
          ),
          const _TextWithBoldTitle(
            title: 'Собираемые персональные данные',
            text: ' – мобильное приложение собирает только контактный номер телефона или электронный почтовый адрес Пользователя (субъекта персональных данных).',
          ),
          const _TextWithBoldTitle(
            title: 'Обработка персональных данных',
            text: ' – любое действие (операция) или совокупность действий (операций), совершаемых с использованием средств автоматизации или без использования таких средств с персональными данными, включая сбор, запись, систематизацию, накопление, хранение, уточнение (обновление, изменение), извлечение, использование, передачу третьим лицам (распространение, предоставление, доступ), обезличивание, блокирование, удаление, уничтожение персональных данных.',
          ),
          const _TextWithBoldTitle(
            title: 'Пользователь',
            text: ' – физическое лицо старше 18 лет или юридическое лицо, принявшее условия Пользовательского соглашения и имеющий правомерный доступ к мобильному приложению, посредством сети Интернет.',
          ),
          const SizedBox(height: 20),
          Text(
            '2. ОБЩИЕ ПОЛОЖЕНИЯ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '2.1. Использование Пользователем услуг мобильного приложения, означает его согласие с настоящей Политикой конфиденциальности и условиями обработки персональных данных Пользователя.\n'
            '2.2. В случае несогласия с условиями Политики конфиденциальности Пользователь должен прекратить использование услуг, материалов и сервисов мобильного приложения.\n'
            '2.3. Настоящая Политика конфиденциальности применяется только по отношению к мобильному приложению.  Администрация не контролирует и не несет ответственности за веб-сайты третьих лиц, на которые Пользователь может перейти по ссылкам, доступным в мобильном приложении. Администрация призывает Пользователя перед представлением своей персональной информации на сторонних веб-сайтах внимательно ознакомиться с их политикой конфиденциальности.\n'
            '2.4. Пользователь заверяет,  что вводимые им персональные данные достоверны и не нарушают законные прав третьих лиц.\n'
            '2.5. Администрация не проверяет достоверность персональных данных Пользователя.\n',
              style: textStyle
          ),
          const SizedBox(height: 20),
          Text(
            '3. ПРЕДМЕТ ПОЛИТИКИ КОНФИДЕНЦИАЛЬНОСТИ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '3.1. Настоящая Политика конфиденциальности устанавливает обязательства Администрации по неразглашению и обеспечению режима защиты конфиденциальности персональных данных, которые Пользователь предоставляет при использовании мобильного приложения.\n'
            '3.2. Администрация предпринимает соответствующие меры для обеспечения безопасности персональной информации Пользователя. Однако метод передачи информации и метод ее хранения в сети Интернет не может быть полностью безопасным, поэтому Администрация не гарантирует абсолютную безопасность персональной информации.\n',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          Text(
            '4. ЦЕЛИ СБОРА ПЕРСОНАЛЬНОЙ ИНФОРМАЦИИ ПОЛЬЗОВАТЕЛЯ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '4.1. Администрация может использовать персональные данные исключительно в целях оформления оказания услуг, а также:\n'
            '4.1.1. установления с Пользователем обратной связи;\n'
            '4.1.2. подтверждения (в случае необходимости) достоверности и полноты персональных данных, предоставленных Пользователем;\n'
            '4.1.3. определения места нахождения Пользователя в целях, определенных Пользовательским соглашением;\n'
            '4.1.4. обработки и получения сведений о выбранных Пользователем категорий услуг мобильного приложения;\n'
            '4.1.5. осуществления рекламной деятельности, но с согласия Пользователя.\n',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          Text(
            '5. СПОСОБЫ И СРОКИ ОБРАБОТКИ ПЕРСОНАЛЬНОЙ ИНФОРМАЦИИ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '5.1. Обработка персональных данных Пользователя осуществляется без ограничения срока, любым законным способом, в том числе в информационных системах персональных данных с использованием средств автоматизации или без использования таких средств.\n'
            '5.2. Пользователь соглашается с тем, что Администрация вправе передавать персональные данные третьим лицам, в частности, кадровым агентствам, работодателям, операторам электросвязи, курьерским службам, исключительно в целях оказания услуг Пользователю.\n'
            '5.3. Персональные данные Пользователя могут быть переданы уполномоченным государственным органам по основаниям и в порядке, предусмотренным законодательством Кыргызской Республики.\n'
            '5.4. При утрате или разглашении персональных данных Администрация информирует Пользователя о случившемся.\n',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          Text(
            '6. ОБЯЗАТЕЛЬСТВА СТОРОН',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          const _TextWithBoldTitle(
            title: '6.1. Пользователь обязан:\n',
            text: '6.1.1. предоставить достоверную и полную информацию о запрашиваемых Администрацией персональных данных (контактный номер телефона и электронный почтовый адрес);\n'
                  '6.1.2. по запросу Администрации предоставить необходимую дополнительную информацию;\n'
                  '6.1.3. соблюдать условия Пользовательского соглашения, а также действующей Политики конфиденциальности.\n',
          ),
          const _TextWithBoldTitle(
            title: '6.2. Администрация обязана:\n',
            text: '6.2.1. использовать полученную информацию исключительно в целях качественного предоставления услуг Пользователям;\n'
                  '6.2.2. обеспечить по мере своей возможности хранение конфиденциальной информации;\n'
                  '6.2.3. отказаться от оказания услуг Пользователю, в случае неуплаты последним стоимости услуг, либо предоставления ложных сведений о персональных данных, которое может затруднить оказание услуг.\n',
          ),
          const SizedBox(height: 20),
          Text(
            '7. ОТВЕТСТВЕННОСТЬ СТОРОН',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '7.1. Администрация, не исполнившая свои обязательства, несёт ответственность в соответствии с законодательством Кыргызской Республики.\n'
            '7.2. В случае утраты или разглашения конфиденциальной информации Администрация не несёт ответственность, если данная конфиденциальная информация:\n'
            '7.2.1. стала носить публичный характер до её утраты или разглашения;\n'
            '7.2.2. относится к общедоступному массиву персональных данных;\n'
            '7.2.3. предоставлена на основании соответствующего запроса уполномоченного государственного органа;\n'
            '7.2.4. получена третьей стороной до момента её получения Администрацией;\n'
            '7.2.5. разглашена с согласия Пользователя.\n',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          Text(
            '8. РАЗРЕШЕНИЕ СПОРОВ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '8.1. Все споры, возникающие из отношений между Пользователем и Администрацией, будут разрешаться путем переговоров и подготовки претензионных писем.\n'
            '8.2. Если Стороны не достигнут соглашения в ходе переговоров, или на полученное претензионное письмо не будет получен ответ в течение 15 (пятнадцати) календарных дней, то спор подлежит рассмотрению в порядке предусмотренном законодательством Кыргызской Республики.\n',
            style: textStyle,
          ),
          const SizedBox(height: 20),
          Text(
            '9. ДОПОЛНИТЕЛЬНЫЕ УСЛОВИЯ',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '9.1. Администрация вправе вносить изменения в настоящую Политику конфиденциальности без согласия Пользователя.\n'
            '9.2. Новая Политика конфиденциальности вступает в силу с момента ее размещения в мобильном приложении, если иное не предусмотрено новой редакцией Политики конфиденциальности.\n'
            '9.3. При дальнейшем пользовании услугами мобильного приложения, Пользователь соглашается с новыми условиями Политики конфиденциальности. В случае несогласия Пользователя с новыми условиями Политики конфиденциальности, Пользователь обязан прекратить использовать мобильное приложение.\n',
            style: textStyle,
          ),
          const SizedBox(height: 60),
          Text(
            'Пользователь подтверждает, что ознакомлен со всеми пунктами настоящей Политики конфиденциальности и безусловно принимает их.',
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _TextWithBoldTitle extends StatelessWidget {
  final String title;
  final String text;

  const _TextWithBoldTitle({
    Key? key,
    required this.title,
    required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textStyle = TextStyle(
      fontSize: 16,
      color: theme.isLight ? theme.onSurfaceVariant : theme.neutral80,
    );

    return Text.rich(
      TextSpan(
        text: title,
        style: textStyle.copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: text,
            style: textStyle.copyWith(fontWeight: FontWeight.normal),
          ),
        ]
      ),
    );
  }
}


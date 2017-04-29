+++
categories = ["y"]
date = "2014-01-12T22:46:27+03:00"
description = ""
tags = ["SAN"]
title = "AoE"

+++

В качестве протокола для проброса блочных устройств по сети (иными словами, для SAN-целей) обычно используют три следующих:

 * iSCSI
 * FC / FCP
 * FCoE
 * AoE

**iSCSI:**

Является очень распространенным, он используется во многих как программных, так и аппаратных решениях (от [qLogic](http://ru.qlogic.com/Pages/default.aspx), например).
Работает поверх TCP/IP, в связи с чем нормально маршрутизируется на Layer 3 (но монтировать его через WAN, по понятным причинам, не стоит). По своей сути инкапсулирует SCSI-команды в IP-пакеты. Не требует какого-либо специализированного оборудования для работы  -- достаточно будет уже существующей сети (из опыта использования -- на линках толщиной менее 2Gbps иногда ведет себя не очень приятно, на линках в 100Mbps его лучше вообще не использовать).

Сейчас его рассматривать подробно не буду (скорее всего, статья по нему чуть позже).

**FC / FCP:** (Fibre Channel/Fibre Channel Protocol)

Протокол делает то же, что и iSCSI -- инкапсулирует SCSI-команды в пакеты, передаваемые по сети. Отличие в том, что если в случае с iSCSI используется Level3-протокол TCP/IP в качестве транспорта, то здесь используется собственный транспортный протокол - **FCP**(Fibre Channel Protocol)
Является специализированным протоколом для передачи данных, и для работы с ним нужно использовать отдельное достаточно дорогостоящее оборудование - самый простой хост-адаптер (аналог банального сетевого адаптера в мире Ethernet/TCP/IP) Qlogic QLE2440-CK в реалиях России стоит порядка 28 тысяч рублей, коммутатор Qlogic SB5600Q-16A  на 12 4gbps-портов - 125 тысяч рублей.
Это автоматически ограничивает масштаб применения решений на FC до систем хранения данных уровня предприятия/дата-центра.
Обладает высокой производительностью за счет отсутствия оверхеда на транспортном уровне, и, косвенно, за счет того, что большинство решений на его основе - аппаратные.

**FCoE:** (Fibre Channel over Ethernet)

К сожалению, перспективы FC в будущем довольно туманны - некоторые программные решения на базе iSCSI сейчас превосходят по производительности хранилища на базе FC, а стоимость их - несравнима.
Скорее всего, будущее корпоративных сетей за FCoE -- FC, использующем в качестве среды обычные jumbo-фреймы на Ethernet-каналах, и позволяющим делать конвергентные сети на уже существующей базе.
Сейчас на рынке в свободном доступе уже есть Ethernet-адаптеры на 40Gbps, тестируются адаптеры на 100Gbps -- native-FC сейчас этому противопоставить пока не может ничего.
Протокол передачи все ещё достаточно новый -- он был подтвержден только в 2009 году, и оборудование, поддерживающее его пока что не представлено достаточно широко.

**AoE:** (ATA over Ethernet)

Последний достаточно распространенный протокол - AoE - он инкапсулирует обычные ATA-команды в Ethernet-фреймы. Работает на 2 уровне по OSI, что имеет как плюсы, так и минусы:

**Плюсы:**
 * Нет оверхеда при работе с жесткими дисками и массивами - нет необходимости выполнять конвертацию ATA в SCSI.
 * Нет оверхеда при передаче данных по сети - используется второй уровень, что позволяет в один и тот же фрейм встроить больший пейлоад.
 * Нет необходимости использовать дорогостоящее оборудование как в случае с Fiber Channel - сгодятся обычные коммутаторы и Ethernet-линки.
 * Поддерживается в ядре с 2.6.11
 * Таргеты и инициаторы есть практически под все ОС.
**Минусы:**
 * Маршрутизировть можно только на L2, иными словами - в пределах одного широковещательного домена.

Позже -- больше, на сегодня хватит.

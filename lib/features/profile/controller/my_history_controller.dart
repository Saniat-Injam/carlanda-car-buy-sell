import 'package:carlanda_car_buy_sell/core/common/entity/history_entity.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:get/get.dart';

class MyHistoryController extends GetxController {
  Rx<HistoryType> selectedHistory = HistoryType.inProgress.obs;

  List<HistoryEntity> inProgressHistorys = <HistoryEntity>[
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.inProgress,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.inProgress,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.inProgress,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.inProgress,
    ),
  ];

  List<HistoryEntity> deliveredHistory = <HistoryEntity>[
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.deliverd,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.deliverd,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.deliverd,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.deliverd,
    ),
  ];

  List<HistoryEntity> cancelledHistory = <HistoryEntity>[
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.cancel,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.cancel,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.cancel,
    ),
    HistoryEntity(
      id: "1",
      title: "Audi . RS Q8 . TFSI V8",
      imagePath: WillDPictures.histroyCar,
      trackingId: "#134509",
      date: "25 July 2025",
      historyType: HistoryType.cancel,
    ),
  ];

  void changeTab({required HistoryType type}) => selectedHistory.value = type;
}

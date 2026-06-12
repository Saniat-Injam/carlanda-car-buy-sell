import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/track_car/presentation/components/status_widget.dart';
import 'package:flutter/material.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StatusWidget(
            title: "Payment Confirm",
            subTitle:
                "We've received your payment and signed the purchase contract.",
            iconPath: IconPath.payment,
            isCompleted: true,
          ),
          StatusWidget(
            title: "Vehicle Shipped",
            subTitle: "Your vehicle has been loaded onto the vessel.",
            iconPath: IconPath.shipment,
            isCompleted: true,
          ),

          StatusWidget(
            title: "Vessel Departure",
            subTitle: "The ship carrying your car has departed the port.",
            iconPath: IconPath.departure,
            isCompleted: true,
          ),

          StatusWidget(
            title: "Arrived at Port",
            subTitle: "Your car has reached the destination port.",
            iconPath: IconPath.port,
            isCompleted: false,
          ),

          StatusWidget(
            title: "Custom Clearance",
            subTitle: "customs procedure are underway",
            iconPath: IconPath.customClearence,
            isCompleted: false,
          ),

          StatusWidget(
            title: "Ready for Delivery",
            subTitle: "Your car is ready to be delivered.",
            iconPath: IconPath.delivery,
            isCompleted: false,
          ),

          StatusWidget(
            title: "Delivered",
            subTitle: "Congratulations! Your vehicle has been delivered.",
            iconPath: IconPath.delivered,
            isCompleted: false,
            showLine: false,
          ),
        ],
      ),
    );
  }
}

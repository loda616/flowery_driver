import 'package:flutter/material.dart';
import '../../../../core/styles/fonts/app_fonts.dart';

class OrderStateIndicator extends StatelessWidget {
  final String state;

  const OrderStateIndicator({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _getStateIcon(),
          color: _getStateColor(),
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          _getStateText(),
          style: AppFonts.font14LightGreyWeight500.copyWith(
            color: _getStateColor(),
          ),
        ),
      ],
    );
  }

  IconData _getStateIcon() {
    switch (state.toLowerCase()) {
      case 'completed':
        return Icons.check_circle_outline;
      case 'cancelled':
        return Icons.cancel_outlined;
      case 'inprogress':
        return Icons.pending_outlined;
      default:
        return Icons.info_outline;
    }
  }

  Color _getStateColor() {
    switch (state.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'inprogress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStateText() {
    switch (state.toLowerCase()) {
      case 'inprogress':
        return 'In Progress';
      default:
        return state[0].toUpperCase() + state.substring(1).toLowerCase();
    }
  }
}
abstract class OrderDetailsRepository {
  Future<void> updateOrderState(String orderId, String state);
  Future<void> startOrder(String orderId);
}

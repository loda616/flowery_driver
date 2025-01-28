abstract class OrderDetailsRemoteDataSource {
  Future<void> updateOrderState(String orderId, String state);
  Future<void> startOrder(String orderId);
}
import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:retrofit/retrofit.dart';

part 'gigaturnip_api_client.g.dart';

@RestApi(baseUrl: "https://journal-bb5e3.uc.r.appspot.com/api/v1/")
abstract class GigaTurnipApiClient {
  factory GigaTurnipApiClient(Dio dio, {String baseUrl}) = _RestClient;

  // Campaign methods

  @GET(campaignsRoute)
  Future<PaginationWrapper<Campaign>> getCampaigns(@Queries() Map<String, dynamic> query);

  @GET(userCampaignsRoute)
  Future<List<Campaign>> getUserCampaigns();

  @GET(selectableCampaignsRoute)
  Future<List<Campaign>> getSelectableCampaigns();

  @GET("$campaignsRoute/{id}")
  Future<Campaign> getCampaignById(@Path("id") String id);

  @GET("$campaignsRoute/{id}/$joinCampaignActionRoute")
  Future<void> joinCampaign(@Path("id") String id);

  // Task methods

  @GET(tasksRoute)
  Future<PaginationWrapper<Task>> getTasks(@Queries() Map<String, dynamic> query);

  @GET(selectableTasksRoute)
  Future<PaginationWrapper<Task>> getUserSelectableTasks(@Queries() Map<String, dynamic> query);

  @GET(relevantTasksRoute)
  Future<List<Task>> getUserRelevantTasks(@Queries() Map<String, dynamic> query);

  @GET("$tasksRoute/{id}")
  Future<Task> getTaskById(@Path("id") String id);

  @GET("$tasksRoute/{id}/$integratedTasksActionRoute")
  Future<List<Task>> getIntegratedTasks(@Path("id") String id);

  @GET("$tasksRoute/{id}/$displayedPreviousTasksActionRoute")
  Future<List<Task>> getDisplayedPreviousTasks(@Path("id") String id);

  @GET("$tasksRoute/{id}/$openPreviousTaskActionRoute")
  Future<Task> openPreviousTask(@Path("id") String id);

  @GET("$tasksRoute/{id}/$releaseTaskActionRoute")
  Future<void> releaseTask(@Path("id") String id);

  @GET("$tasksRoute/{id}/$requestTaskActionRoute")
  Future<void> requestTask(@Path("id") String id);

  @GET("$tasksRoute/{id}/$triggerWebhookActionRoute")
  Future<void> triggerTaskWebhook(@Path("id") String id);

  @GET("$tasksRoute/{id}/$reopenTaskActionRoute")
  Future<void> reopenTask(@Path("id") String id);

  // Notification methods

  @GET(notificationsRoute)
  Future<PaginationWrapper<Notification>> getNotifications(@Queries() Map<String, dynamic> query);

  @GET(userNotificationsRoute)
  Future<PaginationWrapper<Notification>> getUserNotifications(@Queries() Map<String, dynamic> query);

  @GET("$notificationsRoute/{id}/$openNotificationActionRoute")
  Future<void> openNotification(@Path("id") String id);
}

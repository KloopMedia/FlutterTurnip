import 'package:dio/dio.dart';
import 'package:gigaturnip_api/gigaturnip_api.dart';
import 'package:retrofit/retrofit.dart';

part 'gigaturnip_api_client.g.dart';

@RestApi(baseUrl: "https://journal-bb5e3.uc.r.appspot.com/api/v1/")
abstract class GigaTurnipApiClient {
  factory GigaTurnipApiClient(Dio dio, {String baseUrl}) = _GigaTurnipApiClient;

  // User methods
  @GET(deleteInitRoute)
  Future<HttpResponse> deleteUserInit();

  @POST("$usersRoute/{id}/$deleteUserAction")
  Future<HttpResponse> deleteUser(@Path("id") int id, @Body() Map<String, dynamic> data);

  // Campaign methods

  @GET(campaignsRoute)
  Future<PaginationWrapper<Campaign>> getCampaigns({@Queries() Map<String, dynamic>? query});

  @GET(userCampaignsRoute)
  Future<PaginationWrapper<Campaign>> getUserCampaigns({
    @Queries() Map<String, dynamic>? query,
  });

  @GET(selectableCampaignsRoute)
  Future<PaginationWrapper<Campaign>> getSelectableCampaigns({
    @Queries() Map<String, dynamic>? query,
  });

  @GET("$campaignsRoute/{id}")
  Future<Campaign> getCampaignById(@Path("id") int id);

  @GET("$campaignsRoute/{id}/$joinCampaignActionRoute")
  Future<void> joinCampaign(@Path("id") int id);

  // Campaigns filter methods

  @GET(categoriesRoute)
  Future<PaginationWrapper<Category>> getCategories({@Queries() Map<String, dynamic>? query});

  @GET(countriesRoute)
  Future<PaginationWrapper<Country>> getCountries({@Queries() Map<String, dynamic>? query});

  @GET(languagesRoute)
  Future<PaginationWrapper<Language>> getLanguages({@Queries() Map<String, dynamic>? query});

  // Chain methods

  @GET(chainsRoute)
  Future<PaginationWrapper<Chain>> getChains({@Queries() Map<String, dynamic>? query});

  @GET(individualChainsRoute)
  Future<PaginationWrapper<IndividualChain>> getIndividualChains(
      {@Queries() Map<String, dynamic>? query});

  // Task methods

  @GET(tasksRoute)
  Future<PaginationWrapper<Task>> getTasks({@Queries() Map<String, dynamic>? query});

  @GET(selectableTasksRoute)
  Future<PaginationWrapper<Task>> getUserSelectableTasks({@Queries() Map<String, dynamic>? query});

  @GET(relevantTasksRoute)
  Future<PaginationWrapper<Task>> getUserRelevantTasks({@Queries() Map<String, dynamic>? query});

  @GET("$tasksRoute/{id}/")
  Future<TaskDetail> getTaskById(@Path("id") int id);

  @PATCH("$tasksRoute/{id}/")
  Future<TaskResponse> saveTaskById(@Path("id") int id, @Body() Map<String, dynamic> data);

  @GET("$tasksRoute/{id}/$integratedTasksActionRoute")
  Future<List<Task>> getIntegratedTasks(
    @Path("id") int id, {
    @Queries() Map<String, dynamic>? query,
  });

  @GET("$tasksRoute/{id}/$displayedPreviousTasksActionRoute")
  Future<PaginationWrapper<TaskDetail>> getDisplayedPreviousTasks(
    @Path("id") int id, {
    @Queries() Map<String, dynamic>? query,
  });

  @GET("$tasksRoute/{id}/$openPreviousTaskActionRoute")
  Future<Task> openPreviousTask(@Path("id") int id);

  @GET("$tasksRoute/{id}/$releaseTaskActionRoute")
  Future<void> releaseTask(@Path("id") int id);

  @GET("$tasksRoute/{id}/$requestTaskActionRoute")
  Future<void> requestTask(@Path("id") int id);

  @GET("$tasksRoute/{id}/$triggerWebhookActionRoute")
  Future<WebhookResponse> triggerTaskWebhook(@Path("id") int id);

  @GET("$tasksRoute/{id}/$reopenTaskActionRoute")
  Future<void> reopenTask(@Path("id") int id);

  // TaskStage methods

  @GET("$taskStagesRoute/{id}/$loadDynamicSchema")
  Future<DynamicSchema> getDynamicSchema(
    @Path("id") int id, {
    @Queries() required Map<String, dynamic> query,
  });

  @GET(userRelevantTaskStageRoute)
  Future<PaginationWrapper<TaskStage>> getUserRelevantTaskStages({
    @Queries() Map<String, dynamic>? query,
  });

  @GET(selectableTaskStageRoute)
  Future<PaginationWrapper<TaskStage>> getSelectableTaskStages({
    @Queries() Map<String, dynamic>? query,
  });

  @POST("$taskStagesRoute/{id}/$createTaskActionRoute")
  Future<CreateTaskResponse> createTaskFromStageId(@Path("id") int id);

  @GET(availableTaskStageRoute)
  Future<PaginationWrapper<TaskStageDetail>> getAvailableTaskStages({
    @Queries() Map<String, dynamic>? query,
  });

  // Notification methods

  @GET(notificationsRoute)
  Future<PaginationWrapper<Notification>> getNotifications({
    @Queries() Map<String, dynamic>? query,
  });

  @GET(userNotificationsRoute)
  Future<PaginationWrapper<Notification>> getUserNotifications({
    @Queries() Map<String, dynamic>? query,
  });

  @GET("$notificationsRoute/{id}")
  Future<Notification> getNotificationById(@Path("id") int id);

  @GET("$notificationsRoute/{id}/$openNotificationActionRoute")
  Future<void> openNotification(@Path("id") int id);
}

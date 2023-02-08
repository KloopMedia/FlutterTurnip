// Campaigns routes
const campaignsRoute = '/api/v1/campaigns/';
const userCampaignsRoute = '$campaignsRoute/list_user_campaigns/';
const selectableCampaignsRoute = '$campaignsRoute/list_user_selectable/';

// Campaigns actions
const joinCampaignActionRoute = '/join_campaign/';

// TaskStages routes
const taskStagesRoute = '/api/v1/taskstages/';
const userRelevantTaskStageRoute = '$taskStagesRoute/user_relevant/';

// TaskStages actions
const createTaskActionRoute = '/create_task/';

// Tasks routes
const tasksRoute = '/api/v1/tasks/';
const selectableTasksRoute = '$tasksRoute/user_selectable/';
const relevantTasksRoute = '$tasksRoute/user_relevant/';

// Specific task's actions
const integratedTasksActionRoute = '/get_integrated_tasks/';
const displayedPreviousTasksActionRoute = '/list_displayed_previous/';
const openPreviousTaskActionRoute = '/open_previous/';
const releaseTaskActionRoute = '/release_assignment/';
const requestTaskActionRoute = '/request_assignment/';
const triggerWebhookActionRoute = '/trigger_webhook/';
const reopenTaskActionRoute = '/uncomplete/';

// Notifications routes
const notificationsRoute = '/api/v1/notifications/';
const userNotificationsRoute = '$notificationsRoute/list_user_notifications/';
const openNotificationActionRoute = '/open_notification/';
const lastTaskNotificationsActionRoute = '$notificationsRoute/last_task_notifications/';

// Users routes
const usersRoute = '/api/v1/users/';
const deleteInitRoute = '$usersRoute/delete_init/';
const deleteUserAction = '/delete_user/';


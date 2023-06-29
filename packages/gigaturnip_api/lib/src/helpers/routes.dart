// Campaigns routes
const campaignsRoute = 'campaigns/';
const userCampaignsRoute = '${campaignsRoute}list_user_campaigns/';
const selectableCampaignsRoute = '$campaignsRoute/list_user_selectable/';

// Campaigns actions
const joinCampaignActionRoute = 'join_campaign/';

// Campaigns filter routes
const categoriesRoute = 'categories/';
const countriesRoute = 'countries/';
const languagesRoute = 'languages/';

// Chain routes
const chainsRoute = 'chains/';
const individualChainsRoute = '${chainsRoute}individuals/';

// TaskStages routes
const taskStagesRoute = 'taskstages/';
const userRelevantTaskStageRoute = '${taskStagesRoute}user_relevant/';
const selectableTaskStageRoute = '${taskStagesRoute}selectable/';
const availableTaskStageRoute = '${taskStagesRoute}available_stages/';


// TaskStages actions
const createTaskActionRoute = 'create_task/';
const loadDynamicSchema = 'load_schema_answers/';

// Tasks routes
const tasksRoute = 'tasks/';
const selectableTasksRoute = '${tasksRoute}user_selectable/';
const relevantTasksRoute = '${tasksRoute}user_relevant/';

// Specific task's actions
const integratedTasksActionRoute = 'get_integrated_tasks/';
const displayedPreviousTasksActionRoute = 'list_displayed_previous/';
const openPreviousTaskActionRoute = 'open_previous/';
const releaseTaskActionRoute = 'release_assignment/';
const requestTaskActionRoute = 'request_assignment/';
const triggerWebhookActionRoute = 'trigger_webhook/';
const reopenTaskActionRoute = 'uncomplete/';

// Notifications routes
const notificationsRoute = 'notifications/';
const userNotificationsRoute = '${notificationsRoute}list_user_notifications/';

// Notifications actions
const openNotificationActionRoute = 'open_notification/';

// Users routes
const usersRoute = 'users/';
const deleteInitRoute = '$usersRoute/delete_init/';
const deleteUserAction = '/delete_user/';
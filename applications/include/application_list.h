/*
 * Copyright 2015-2019 NSSLab, KAIST
 */

/**
 * \file
 * \author Jaehyun Nam <namjh@kaist.ac.kr>
 */

#pragma once

/** \brief The macro for the main function of an application */
#define DECLARE_MAIN_FUNC(name) \
    extern int name(int *activated, int argc, char **argv)
/** \brief The macro for the handler function of an application */
#define DECLARE_HANDLER_FUNC(name) \
    extern int name(const app_event_t *av, app_event_out_t *av_out)
/** \brief The macro for the cleanup function of an application */
#define DECLARE_CLEANUP_FUNC(name) \
    extern int name(int *activated)
/** \brief The macro for the CLI function of an application */
#define DECLARE_CLI_FUNC(name) \
    extern int name(cli_t *cli, char **args)

DECLARE_MAIN_FUNC(appint_main);
DECLARE_HANDLER_FUNC(appint_handler);
DECLARE_CLEANUP_FUNC(appint_cleanup);
DECLARE_CLI_FUNC(appint_cli);

DECLARE_MAIN_FUNC(l2_learning_main);
DECLARE_HANDLER_FUNC(l2_learning_handler);
DECLARE_CLEANUP_FUNC(l2_learning_cleanup);
DECLARE_CLI_FUNC(l2_learning_cli);

DECLARE_MAIN_FUNC(l2_shortest_main);
DECLARE_HANDLER_FUNC(l2_shortest_handler);
DECLARE_CLEANUP_FUNC(l2_shortest_cleanup);
DECLARE_CLI_FUNC(l2_shortest_cli);

DECLARE_MAIN_FUNC(rbac_main);
DECLARE_HANDLER_FUNC(rbac_handler);
DECLARE_CLEANUP_FUNC(rbac_cleanup);
DECLARE_CLI_FUNC(rbac_cli);

DECLARE_MAIN_FUNC(benign_app_main);
DECLARE_HANDLER_FUNC(benign_app_handler);
DECLARE_CLEANUP_FUNC(benign_app_cleanup);
DECLARE_CLI_FUNC(benign_app_cli);

DECLARE_MAIN_FUNC(malicious_app_main);
DECLARE_HANDLER_FUNC(malicious_app_handler);
DECLARE_CLEANUP_FUNC(malicious_app_cleanup);
DECLARE_CLI_FUNC(malicious_app_cli);

DECLARE_MAIN_FUNC(app_event_monitor_main);
DECLARE_HANDLER_FUNC(app_event_monitor_handler);
DECLARE_CLEANUP_FUNC(app_event_monitor_cleanup);
DECLARE_CLI_FUNC(app_event_monitor_cli);

/** \brief The function pointer of an application */
struct _app_func_t {
    char *name; /**< Application name */
    app_main_f main; /**< The main function pointer */
    app_handler_f handler; /**< The handler function pointer */
    app_cleanup_f cleanup; /**< The cleanup function pointer */
    app_cli_f cli; /**< The CLI function pointer */
} g_applications[] = {
    {"appint", appint_main, appint_handler, appint_cleanup, appint_cli},
    {"l2_learning", l2_learning_main, l2_learning_handler, l2_learning_cleanup, l2_learning_cli},
    {"rbac", rbac_main, rbac_handler, rbac_cleanup, rbac_cli},
    {"benign_app", benign_app_main, benign_app_handler, benign_app_cleanup, benign_app_cli},
    {"malicious_app", malicious_app_main, malicious_app_handler, malicious_app_cleanup, malicious_app_cli},
    {"app_event_monitor", app_event_monitor_main, app_event_monitor_handler, app_event_monitor_cleanup, app_event_monitor_cli},
}; /**< The list of function pointers */

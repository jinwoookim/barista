/*
 * Copyright 2015-2019 NSSLab, KAIST
 */

/**
 * \ingroup compnt
 * @{
 * \defgroup stat_mgmt Statistics Management
 * \brief (Management) statistics management
 * @{
 */

/**
 * \file
 * \author Jaehyun Nam <namjh@kaist.ac.kr>
 */

#include "stat_mgmt.h"

/** \brief Statistics management ID */
#define STAT_MGMT_ID 4203880464

/////////////////////////////////////////////////////////////////////

/**
 * \brief Function to request aggregate stats
 * \param dpid Datapath ID
 */
static int aggregate_stats_request(uint64_t dpid)
{
    flow_t flow = {0};

    flow.dpid = dpid;

    ev_dp_request_aggregate_stats(STAT_MGMT_ID, &flow);

    return 0;
}

/**
 * \brief Function to request port stats
 * \param dpid Datapath ID
 */
static int port_stats_request(uint64_t dpid)
{
    port_t port = {0};

    port.dpid = dpid;
    port.port = PORT_NONE;

    ev_dp_request_port_stats(STAT_MGMT_ID, &port);

    return 0;
}

/////////////////////////////////////////////////////////////////////

/**
 * \brief The main function
 * \param activated The activation flag of this component
 * \param argc The number of arguments
 * \param argv Arguments
 */
int stat_mgmt_main(int *activated, int argc, char **argv)
{
    LOG_INFO(STAT_MGMT_ID, "Init - Statistics management");

    switch_list = (uint64_t *)CALLOC(__MAX_NUM_SWITCHES, sizeof(uint64_t));
    if (switch_list == NULL) {
        LOG_ERROR(STAT_MGMT_ID, "calloc() failed");
        return -1;
    }

    pthread_rwlock_init(&stat_lock, NULL);

    activate();

    while (*activated) {
        pthread_rwlock_rdlock(&stat_lock);

        int i;
        for (i=0; i<__MAX_NUM_SWITCHES; i++) {
            if (switch_list[i]) {
                // aggregate stats
                aggregate_stats_request(switch_list[i]);

                // port stats
                port_stats_request(switch_list[i]);
            }
        }

        pthread_rwlock_unlock(&stat_lock);

        for (i=0; i<__STAT_MGMT_REQUEST_TIME; i++) {
            if (*activated == FALSE) break;
            else waitsec(1, 0);
        }
    }

    return 0;
}

/**
 * \brief The cleanup function
 * \param activated The activation flag of this component
 */
int stat_mgmt_cleanup(int *activated)
{
    LOG_INFO(STAT_MGMT_ID, "Clean up - Statistics management");

    deactivate();

    pthread_rwlock_destroy(&stat_lock);
    FREE(switch_list);

    return 0;
}

/**
 * \brief The CLI function
 * \param cli The pointer of the Barista CLI
 * \param args Arguments
 */
int stat_mgmt_cli(cli_t *cli, char **args)
{
    cli_print(cli, "No CLI support");

    return 0;
}

/**
 * \brief The handler function
 * \param ev Read-only event
 * \param ev_out Read-write event (if this component has the write permission)
 */
int stat_mgmt_handler(const event_t *ev, event_out_t *ev_out)
{
    switch (ev->type) {
    case EV_SW_CONNECTED:
        PRINT_EV("EV_SW_CONNECTED\n");
        {
            const switch_t *sw = ev->sw;

            if (sw->remote == TRUE) break;

            pthread_rwlock_wrlock(&stat_lock);

            int i;
            for (i=0; i<__MAX_NUM_SWITCHES; i++) {
                if (switch_list[i] == 0) {
                    switch_list[i] = sw->dpid;
                    break;
                }
            }

            pthread_rwlock_unlock(&stat_lock);
        }
        break;
    case EV_SW_DISCONNECTED:
        PRINT_EV("EV_SW_DISCONNECTED\n");
        {
            const switch_t *sw = ev->sw;

            if (sw->remote == TRUE) break;

            pthread_rwlock_wrlock(&stat_lock);

            int i;
            for (i=0; i<__MAX_NUM_SWITCHES; i++) {
                if (switch_list[i] == sw->dpid) {
                    switch_list[i] = 0;
                    break;
                }
            }

            pthread_rwlock_unlock(&stat_lock);
        }
        break;
    default:
        break;
    }

    return 0;
}

/**
 * @}
 *
 * @}
 */

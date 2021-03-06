/*
 * Copyright 2015-2019 NSSLab, KAIST
 */

/**
 * \ingroup framework
 * @{
 * \defgroup storage Storage Management
 * \brief Functions to maintain the context of the Barista NOS in a storage
 * @{
 */

/**
 * \file
 * \author Jaehyun Nam <namjh@kaist.ac.kr>
 */

#include "storage.h"

/////////////////////////////////////////////////////////////////////

/** \brief The context of the Barista NOS */
ctx_t *st_ctx;

/////////////////////////////////////////////////////////////////////

/**
 * \brief Function to initialize a storage
 * \param ctx The context of the Barista NOS
 */
int init_storage(ctx_t *ctx)
{
    st_ctx = ctx;

    if (get_database_info(&st_ctx->storage, "barista")) {
        PERROR("get_database_info() failed");
        return -1;
    }

    return 0;
}

/**
 * \brief Function to destroy a storage
 * \param ctx The context of the Barista NOS
 */
int destroy_storage(ctx_t *ctx)
{
    return 0;
}

/**
 * @}
 *
 * @}
 */

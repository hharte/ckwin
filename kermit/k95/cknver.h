#ifndef CKNVER_H
#define CKNVER_H

#include "ckover.h"

/*
 * Version numbers used in Windows Resource Files
 */
#define VERSION_MAJOR 3
#define VERSION_MINOR 0
#define VERSION_REVISION 5
#ifndef VERSION_BUILD
#define VERSION_BUILD 0
#endif
#define VERSION_YEAR "2024"
#define VERSION_PRODUCT "C-Kermit for Windows"
#define VERSION_PRODUCT_SHORT "CKW"

/* Version number with just the major and minor numbers */
#define APP_VERSION_MAJ_MIN STR(VERSION_MAJOR) "." STR(VERSION_MINOR)

/* Version number with major, minor and revision */
#define APP_VERSION_STR APP_VERSION_MAJ_MIN "." STR(VERSION_REVISION)


/*
 * Version numbers used in the Windows Resource File
 */

/* File version (comma separated), all components */
#define RC_FILE_VERSION K95_VERSION_MAJOR,K95_VERSION_MINOR,K95_VERSION_REVISION,\
    K95_VERSION_BUILD

/* File version (comma separated) string, all components */
#define RC_FILE_VERSION_STR STR(K95_VERSION_MINOR) ", " STR(K95_VERSION_MINOR) ", " \
    STR(K95_VERSION_REVISION) ", " STR(K95_VERSION_BUILD) "\0"

/* Product version (comma separated), all components */
#define RC_PROD_VERSION RC_FILE_VERSION

/* Product version (comma separated) string, major & minor only */
#define RC_PROD_VERSION_STR K95_VERSION_MAJ_MIN "\0"

#endif // CKNVER_H


#ifdef TP_CLUTTER_DEPRECATIONS
#define CLUTTER_VERSION_MIN_REQUIRED CLUTTER_VERSION_CUR_STABLE
#else
#define CLUTTER_DISABLE_DEPRECATION_WARNINGS
#endif

#include "clutter/clutter.h"

#ifdef TP_NEW_MEDIA
#include <clutter-gst/clutter-gst.h>
#endif

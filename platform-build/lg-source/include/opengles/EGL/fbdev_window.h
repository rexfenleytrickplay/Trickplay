/*
 * This confidential and proprietary software may be used only as
 * authorised by a licensing agreement from ARM Limited
 * (C) COPYRIGHT 2008-2011 ARM Limited
 * ALL RIGHTS RESERVED
 * The entire notice above must be reproduced on all authorised
 * copies and copies may only be made to the extent permitted
 * by a licensing agreement from ARM Limited.
 */

/**
 * @file fbdev_window.h
 * @brief A window type for the framebuffer device (used by egl and tests)
 */

#ifndef _FBDEV_WINDOW_H_
#define _FBDEV_WINDOW_H_

#ifdef __cplusplus
extern "C" {
#endif

typedef enum
{
	FBDEV_PIXMAP_DEFAULT = 0,
	FBDEV_PIXMAP_SUPPORTS_UMP = (1<<0),
	FBDEV_PIXMAP_ALPHA_FORMAT_PRE = (1<<1),
	FBDEV_PIXMAP_COLORSPACE_sRGB = (1<<2)
} fbdev_pixmap_flags;


/** LGE extended fbdev_window structure 
 *
 *
 */
typedef struct fbdev_window
{
        unsigned short x;   			/* image position. valid only if MALI_USE_LGE_EXTEND enabled */
        unsigned short y;				/* image position. valid only if MALI_USE_LGE_EXTEND enabled */

	unsigned short width; 		/* input display size*/
        unsigned short height; 			/* input display size */
        unsigned char bStretchToDisplay; /* 0: input display size, 1: stretch display size. valid only if MALI_USE_LGE_EXTEND enabled */
} fbdev_window;

typedef struct fbdev_pixmap
{
	unsigned int height;
	unsigned int width;
	unsigned int bytes_per_pixel;
	unsigned char buffer_size;
	unsigned char red_size;
	unsigned char green_size;
	unsigned char blue_size;
	unsigned char alpha_size;
	unsigned char luminance_size;
	fbdev_pixmap_flags flags;
	unsigned short *data;
	unsigned int format; /* extra format information in case rgbal is not enough, especially for YUV formats */
} fbdev_pixmap;

#ifdef __cplusplus
}
#endif


#endif
//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASUtilities.h"
#import "GJMASConstraintMaker.h"
#import "GJMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating GJMASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (MASAdditions)

/**
 *	following properties return a new GJMASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) GJMASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

#if TARGET_OS_IPHONE

@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) GJMASViewAttribute *mas_centerYWithinMargins;

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a GJMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(^)(GJMASConstraintMaker *make))block;

/**
 *  Creates a GJMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(^)(GJMASConstraintMaker *make))block;

/**
 *  Creates a GJMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(^)(GJMASConstraintMaker *make))block;

@end

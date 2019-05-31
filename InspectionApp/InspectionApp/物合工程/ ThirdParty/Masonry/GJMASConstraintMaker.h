//
//  MASConstraintBuilder.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GJMASConstraint.h"
#import "MASUtilities.h"

typedef NS_OPTIONS(NSInteger, MASAttribute) {
    MASAttributeLeft = 1 << NSLayoutAttributeLeft,
    MASAttributeRight = 1 << NSLayoutAttributeRight,
    MASAttributeTop = 1 << NSLayoutAttributeTop,
    MASAttributeBottom = 1 << NSLayoutAttributeBottom,
    MASAttributeLeading = 1 << NSLayoutAttributeLeading,
    MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    MASAttributeWidth = 1 << NSLayoutAttributeWidth,
    MASAttributeHeight = 1 << NSLayoutAttributeHeight,
    MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    MASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if TARGET_OS_IPHONE
    
    MASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    MASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    MASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    MASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    MASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    MASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    MASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    MASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface GJMASConstraintMaker : NSObject

/**
 *	The following properties return a new GJMASViewConstraint
 *  with the first item set to the makers associated view and the appropriate GJMASViewAttribute
 */
@property (nonatomic, strong, readonly) GJMASConstraint *left;
@property (nonatomic, strong, readonly) GJMASConstraint *top;
@property (nonatomic, strong, readonly) GJMASConstraint *right;
@property (nonatomic, strong, readonly) GJMASConstraint *bottom;
@property (nonatomic, strong, readonly) GJMASConstraint *leading;
@property (nonatomic, strong, readonly) GJMASConstraint *trailing;
@property (nonatomic, strong, readonly) GJMASConstraint *width;
@property (nonatomic, strong, readonly) GJMASConstraint *height;
@property (nonatomic, strong, readonly) GJMASConstraint *centerX;
@property (nonatomic, strong, readonly) GJMASConstraint *centerY;
@property (nonatomic, strong, readonly) GJMASConstraint *baseline;

#if TARGET_OS_IPHONE

@property (nonatomic, strong, readonly) GJMASConstraint *leftMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *rightMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *topMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) GJMASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) GJMASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new GJMASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  MASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) GJMASConstraint *(^attributes)(MASAttribute attrs);

/**
 *	Creates a GJMASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate GJMASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) GJMASConstraint *edges;

/**
 *	Creates a GJMASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate GJMASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) GJMASConstraint *size;

/**
 *	Creates a GJMASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate GJMASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) GJMASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any MASConstrait are created with this view as the first item
 *
 *	@return	a new GJMASConstraintMaker
 */
- (id)initWithView:(MAS_VIEW *)view;

/**
 *	Calls install method on any MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MASConstraints
 */
- (NSArray *)install;

- (GJMASConstraint * (^)(dispatch_block_t))group;

@end

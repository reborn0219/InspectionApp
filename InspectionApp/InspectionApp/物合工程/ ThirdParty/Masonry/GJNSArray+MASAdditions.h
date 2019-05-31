//
//  NSArray+MASAdditions.h
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "MASUtilities.h"
#import "GJMASConstraintMaker.h"
#import "GJMASViewAttribute.h"

@interface NSArray (MASAdditions)

/**
 *  Creates a GJMASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing on each view
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(^)(GJMASConstraintMaker *make))block;

/**
 *  Creates a GJMASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(^)(GJMASConstraintMaker *make))block;

/**
 *  Creates a GJMASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  All constraints previously installed for the views will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(^)(GJMASConstraintMaker *make))block;

@end

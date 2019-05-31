//
//  GJMASConstraint+Private.h
//  Masonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "GJMASConstraint.h"

@protocol MASConstraintDelegate;


@interface GJMASConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually GJMASConstraintMaker but could be a parent GJMASConstraint
 */
@property (nonatomic, weak) id<MASConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with MASEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface GJMASConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    GJMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (GJMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (GJMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol MASConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A GJMASViewConstraint may turn into a GJMASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(GJMASConstraint *)constraint shouldBeReplacedWithConstraint:(GJMASConstraint *)replacementConstraint;

- (GJMASConstraint *)constraint:(GJMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end

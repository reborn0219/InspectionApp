//
//  UIView+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "GJView+MASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface MAS_VIEW (MASShorthandAdditions)

@property (nonatomic, strong, readonly) GJMASViewAttribute *left;
@property (nonatomic, strong, readonly) GJMASViewAttribute *top;
@property (nonatomic, strong, readonly) GJMASViewAttribute *right;
@property (nonatomic, strong, readonly) GJMASViewAttribute *bottom;
@property (nonatomic, strong, readonly) GJMASViewAttribute *leading;
@property (nonatomic, strong, readonly) GJMASViewAttribute *trailing;
@property (nonatomic, strong, readonly) GJMASViewAttribute *width;
@property (nonatomic, strong, readonly) GJMASViewAttribute *height;
@property (nonatomic, strong, readonly) GJMASViewAttribute *centerX;
@property (nonatomic, strong, readonly) GJMASViewAttribute *centerY;
@property (nonatomic, strong, readonly) GJMASViewAttribute *baseline;
@property (nonatomic, strong, readonly) GJMASViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if TARGET_OS_IPHONE

@property (nonatomic, strong, readonly) GJMASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) GJMASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) GJMASViewAttribute *centerYWithinMargins;

#endif

- (NSArray *)makeConstraints:(void(^)(GJMASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(GJMASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(GJMASConstraintMaker *make))block;

@end

#define MAS_ATTR_FORWARD(attr)  \
- (GJMASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}

@implementation MAS_VIEW (MASShorthandAdditions)

MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);
MAS_ATTR_FORWARD(baseline);

#if TARGET_OS_IPHONE

MAS_ATTR_FORWARD(leftMargin);
MAS_ATTR_FORWARD(rightMargin);
MAS_ATTR_FORWARD(topMargin);
MAS_ATTR_FORWARD(bottomMargin);
MAS_ATTR_FORWARD(leadingMargin);
MAS_ATTR_FORWARD(trailingMargin);
MAS_ATTR_FORWARD(centerXWithinMargins);
MAS_ATTR_FORWARD(centerYWithinMargins);

#endif

- (GJMASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}

- (NSArray *)makeConstraints:(void(^)(GJMASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(GJMASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(GJMASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif

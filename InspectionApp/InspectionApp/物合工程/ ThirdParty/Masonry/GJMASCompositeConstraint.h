//
//  GJMASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GJMASConstraint.h"
#import "MASUtilities.h"

/**
 *	A group of GJMASConstraint objects
 */
@interface GJMASCompositeConstraint : GJMASConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child MASConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end

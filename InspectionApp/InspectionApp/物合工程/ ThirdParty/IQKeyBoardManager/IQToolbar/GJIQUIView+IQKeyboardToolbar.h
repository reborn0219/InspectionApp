//
//  UIView+GJIQToolbar.h
// https://github.com/hackiftekhar/GJIQKeyboardManager
// Copyright (c) 2013-16 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIView.h>

@class UIBarButtonItem;

/**
 UIView category methods to add GJIQToolbar on UIKeyboard.
 */
@interface UIView (IQToolbarAddition)


///-------------------------
/// @name Title and Distance
///-------------------------

/**
 If shouldHideTitle is YES, then title will not be added to the toolbar. Default to NO.
 */
@property (assign, nonatomic) BOOL shouldHideTitle;


///-----------------------------------------
/// @name Customised Invocation Registration
///-----------------------------------------

/**
 Additional target & action to do get callback action. Note that setting custom `previous` selector doesn't affect native `previous` functionality, this is just used to notifiy user to do additional work according to need.
 
 @param target Target object.
 @param action Target Selector.
 */
-(void)setCustomPreviousTarget:(nullable id)target action:(nullable SEL)action;

/**
 Additional target & action to do get callback action. Note that setting custom `next` selector doesn't affect native `next` functionality, this is just used to notifiy user to do additional work according to need.
 
 @param target Target object.
 @param action Target Selector.
 */
-(void)setCustomNextTarget:(nullable id)target action:(nullable SEL)action;

/**
 Additional target & action to do get callback action. Note that setting custom `done` selector doesn't affect native `done` functionality, this is just used to notifiy user to do additional work according to need.
 
 @param target Target object.
 @param action Target Selector.
 */
-(void)setCustomDoneTarget:(nullable id)target action:(nullable SEL)action;

/**
 Customized Invocation to be called on previous arrow action. previousInvocation is internally created using setCustomPreviousTarget: method.
 */
@property (nullable, strong, nonatomic) NSInvocation *previousInvocation;

/**
 Customized Invocation to be called on next arrow action. nextInvocation is internally created using setCustomNextTarget: method.
 */
@property (nullable, strong, nonatomic) NSInvocation *nextInvocation;

/**
 Customized Invocation to be called on done action. doneInvocation is internally created using setCustomDoneTarget: method.
 */
@property (nullable, strong, nonatomic) NSInvocation *doneInvocation;

///------------
/// @name Done
///------------

/**
 Helper function to add Done button on keyboard.
 
 @param target Target object for selector.
 @param action Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action;

/**
 Helper function to add Done button on keyboard.
 
 @param target Target object for selector.
 @param action Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;

/**
 Helper function to add Done button on keyboard.
 
 @param target Target object for selector.
 @param action Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

///------------
/// @name Right
///------------

/**
 Helper function to add Right button on keyboard.
 
 @param text Title for rightBarButtonItem, usually 'Done'.
 @param target Target object for selector.
 @param action Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action;

/**
 Helper function to add Right button on keyboard.
 
 @param text Title for rightBarButtonItem, usually 'Done'.
 @param target Target object for selector.
 @param action Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;

/**
 Helper function to add Right button on keyboard.
 
 @param text Title for rightBarButtonItem, usually 'Done'.
 @param target Target object for selector.
 @param action Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

/**
 Helper function to add Right button on keyboard.
 
 @param image Image icon to use as right button.
 @param target Target object for selector.
 @param action Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addRightButtonOnKeyboardWithImage:(nullable UIImage*)image target:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)showPlaceholder;

/**
 Helper function to add Right button on keyboard.
 
 @param image Image icon to use as right button.
 @param target Target object for selector.
 @param action Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addRightButtonOnKeyboardWithImage:(nullable UIImage*)image target:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;

///------------------
/// @name Cancel/Done
///------------------

/**
 Helper function to add Cancel and Done button on keyboard.
 
 @param target Target object for selector.
 @param cancelAction Cancel button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction;

/**
 Helper function to add Cancel and Done button on keyboard.
 
 @param target Target object for selector.
 @param cancelAction Cancel button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction titleText:(nullable NSString*)titleText;

/**
 Helper function to add Cancel and Done button on keyboard.
 
 @param target Target object for selector.
 @param cancelAction Cancel button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

///-----------------
/// @name Right/Left
///-----------------

/**
 Helper function to add Left and Right button on keyboard.
 
 @param target Target object for selector.
 @param leftButtonTitle Title for leftBarButtonItem, usually 'Cancel'.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param leftButtonAction Left button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param rightButtonAction Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction;

/**
 Helper function to add Left and Right button on keyboard.
 
 @param target Target object for selector.
 @param leftButtonTitle Title for leftBarButtonItem, usually 'Cancel'.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param leftButtonAction Left button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param rightButtonAction Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;

/**
 Helper function to add Left and Right button on keyboard.
 
 @param target Target object for selector.
 @param leftButtonTitle Title for leftBarButtonItem, usually 'Cancel'.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param leftButtonAction Left button action name. Usually 'cancelAction:(GJIQBarButtonItem*)item'.
 @param rightButtonAction Right button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

///-------------------------
/// @name Previous/Next/Done
///-------------------------

/**
 Helper function to add ArrowNextPrevious and Done button on keyboard.
 
 @param target Target object for selector.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction;

/**
 Helper function to add ArrowNextPrevious and Done button on keyboard.
 
 @param target Target object for selector.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction titleText:(nullable NSString*)titleText;

/**
 Helper function to add ArrowNextPrevious and Done button on keyboard.
 
 @param target Target object for selector.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param doneAction Done button action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

///--------------------------
/// @name Previous/Next/Right
///--------------------------

/**
 Helper function to add ArrowNextPrevious and Right button on keyboard.
 
 @param target Target object for selector.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param rightButtonAction RightBarButton action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 */
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction;

/**
 Helper function to add ArrowNextPrevious and Right button on keyboard.
 
 @param target Target object for selector.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param rightButtonAction RightBarButton action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;

/**
 Helper function to add ArrowNextPrevious and Right button on keyboard.
 
 @param target Target object for selector.
 @param rightButtonTitle Title for rightBarButtonItem, usually 'Done'.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param rightButtonAction RightBarButton action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;

/**
 Helper function to add ArrowNextPrevious and Right button on keyboard.
 
 @param target Target object for selector.
 @param rightButtonImage Image icon to use as rightBarButtonItem.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param rightButtonAction RightBarButton action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param titleText text to show as title in GJIQToolbar'.
 */
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonImage:(nullable UIImage*)rightButtonImage previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;

/**
 Helper function to add ArrowNextPrevious and Right button on keyboard.
 
 @param target Target object for selector.
 @param rightButtonImage Image icon to use as rightBarButtonItem.
 @param previousAction Previous button action name. Usually 'previousAction:(id)item'.
 @param nextAction Next button action name. Usually 'nextAction:(id)item'.
 @param rightButtonAction RightBarButton action name. Usually 'doneAction:(GJIQBarButtonItem*)item'.
 @param shouldShowPlaceholder A boolean to indicate whether to show textField placeholder on GJIQToolbar'.
 */
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonImage:(nullable UIImage*)rightButtonImage previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;


///-----------------------------------
/// @name Enable/Disable Previous/Next
///-----------------------------------

/**
 Helper function to enable and disable previous next buttons.
 
 @param isPreviousEnabled BOOL to enable/disable previous button on keyboard.
 @param isNextEnabled  BOOL to enable/disable next button on keyboard..
 */
- (void)setEnablePrevious:(BOOL)isPreviousEnabled next:(BOOL)isNextEnabled;

@end



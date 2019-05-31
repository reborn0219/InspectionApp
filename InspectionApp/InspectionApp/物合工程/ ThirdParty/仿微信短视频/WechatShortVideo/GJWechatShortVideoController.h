
#import <UIKit/UIKit.h>
#import "WechatShortVideoConfig.h"

@protocol WechatShortVideoDelegate <NSObject>

- (void)finishWechatShortVideoCapture:(NSURL *)filePath;

@end

@interface GJWechatShortVideoController : UIViewController

@property(nonatomic, weak) id<WechatShortVideoDelegate> delegate;

/**
 * Do something when video saved success.
 */
- (void)doNextWhenVideoSavedSuccess;

@end

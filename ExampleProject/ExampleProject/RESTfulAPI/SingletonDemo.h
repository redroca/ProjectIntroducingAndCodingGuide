
#import <UIKit/UIKit.h>


@interface SingletonDemo : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (instancetype)sharedInstance;

@end

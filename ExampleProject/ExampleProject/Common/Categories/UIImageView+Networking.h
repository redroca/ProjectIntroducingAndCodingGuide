//
//  UIImageView+Networking.h
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+Extension.h"


typedef NS_ENUM(NSInteger, ImgPlaceholderType) {
    PlaceholderImgBigSquare = 0,
    PlaceholderImgMidLogoSquare = 1,
    PlaceholderImgSmallGrayLogoSquare = 2,
    PlaceholderImgBigRectangle = 3,
    PlaceholderImgLickLogoRectangle = 4,
    PlaceholderImgGrayConcertPoster = 5,
    PlaceholderImgNone = 6
};

@interface UIImageView (Networking)

- (void) requestImageDataURL:(NSURL *) url withPlaceholder:(ImgPlaceholderType) placeholder;
- (void) requestImageDataURL:(NSURL *) url withPlaceholder:(ImgPlaceholderType) placeholder completion:(ImageCompletionBlock)completion;

- (void) requestImageDataURLString:(NSString *) urlString withPlaceholder:(ImgPlaceholderType) placeholder;
- (void) requestImageDataURLString:(NSString *) urlString withPlaceholder:(ImgPlaceholderType) placeholder completion:(ImageCompletionBlock)completion;

@end

//
//  UIImageView+Networking.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "UIImageView+Networking.h"

@implementation UIImageView (Networking)

- (void) requestImageDataURL:(NSURL *) url withPlaceholder:(ImgPlaceholderType) placeholder {
    [self setupImg:url WithPlaceholder:placeholder];
}
- (void) requestImageDataURL:(NSURL *) url withPlaceholder:(ImgPlaceholderType) placeholder completion:(ImageCompletionBlock)completion {
    [self setupImg:url WithPlaceholder:placeholder completion:completion];
}

- (void) requestImageDataURLString:(NSString *) urlString withPlaceholder:(ImgPlaceholderType) placeholder {
    NSURL *url = [NSURL URLWithString:urlString];
    [self setupImg:url WithPlaceholder:placeholder];
}

- (void) requestImageDataURLString:(NSString *) urlString withPlaceholder:(ImgPlaceholderType) placeholder completion:(ImageCompletionBlock)completion {
    if (urlString == nil) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (url == nil) {
        return;
    }
    [self setupImg:url WithPlaceholder:placeholder completion:completion];
}

- (void) setupImg:(NSURL *) url WithPlaceholder:(ImgPlaceholderType) placeholder completion:(ImageCompletionBlock)completion {
    [self img:url
withPlaceholder:[self getPlaceholderImg:placeholder]
   completion:^(BOOL loadFinish, UIImage *image, NSURL *url, NSError *error) {
       completion(loadFinish, image, url, error);
    }];
}

- (void) setupImg:(NSURL *) url WithPlaceholder:(ImgPlaceholderType) placeholder {
    [self img:url withPlaceholder:[self getPlaceholderImg:placeholder] completion:nil];
}

- (UIImage *) getPlaceholderImg:(ImgPlaceholderType) placeholder {
    UIImage *placeholderImg = nil;
    if (placeholder == PlaceholderImgBigSquare) {
        placeholderImg = [UIImage imageNamed:@""];
    }
    else if (placeholder == PlaceholderImgMidLogoSquare) {
        placeholderImg = [UIImage imageNamed:@""];
    }
    else if (placeholder == PlaceholderImgSmallGrayLogoSquare) {
        placeholderImg = [UIImage imageNamed:@""];
    }
    else if (placeholder == PlaceholderImgBigRectangle) {
        placeholderImg = [UIImage imageNamed:@""];
    }
    else if (placeholder == PlaceholderImgLickLogoRectangle) {
        placeholderImg = [UIImage imageNamed:@""];
    }
    else if (placeholder == PlaceholderImgGrayConcertPoster) {
        placeholderImg = [UIImage imageNamed:@""];
    } else { //PlaceholderImgNone
        placeholderImg = [[UIImage alloc] init];
    }
    return placeholderImg;
}

@end

//
//  BlockBackgroundLandscape.h
//  arrived
//
//  Created by Gustavo Ambrozio on 29/11/11.
//  Copyright (c) 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockBackgroundLandscape : UIWindow {
@private
    UIWindow *_previousKeyWindow;
}

+ (BlockBackgroundLandscape *) sharedInstance;

- (void)addToMainWindow:(UIView *)view;
- (void)reduceAlphaIfEmpty;
- (void)removeView:(UIView *)view;

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, readwrite) BOOL vignetteBackground;

@end

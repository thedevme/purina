//
//  BlockAlertViewLandscape.h
//
//

#import <UIKit/UIKit.h>

@interface BlockAlertViewLandscape : NSObject {
@protected
    UIView *_view;
    NSMutableArray *_blocks;
    CGFloat _height;
    CGFloat _width;
}

+ (BlockAlertViewLandscape *)alertWithTitle:(NSString *)title message:(NSString *)message;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block;

- (void)showWithOneButton;
- (void)show;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, readonly) UIView *view;
@property (nonatomic, readwrite) BOOL vignetteBackground;
@property (nonatomic) int numHeightOffset;
@property (nonatomic) int numTitleOffset;
@property (nonatomic) int numMessageOffset;

@property(nonatomic) int numTestOffset;
@property(nonatomic) CGFloat numButtonXOffset;
@property(nonatomic) CGFloat numButtonYOffset;
@end

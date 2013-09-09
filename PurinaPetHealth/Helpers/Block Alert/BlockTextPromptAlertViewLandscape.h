//
//  BlockTextPromptAlertViewLandscape.h
//  BlockAlertsDemo
//
//  Created by Barrett Jacobsen on 2/13/12.
//  Copyright (c) 2012 Barrett Jacobsen. All rights reserved.
//

#import "BlockAlertViewLandscape.h"

@class BlockTextPromptAlertViewLandscape;

typedef BOOL(^TextFieldReturnCallBack)(BlockTextPromptAlertViewLandscape *);

@interface BlockTextPromptAlertViewLandscape : BlockAlertViewLandscape <UITextFieldDelegate> {
    
    NSCharacterSet *unacceptedInput;
    NSInteger maxLength;
}

@property (nonatomic, retain) UITextField *textField;

+ (BlockTextPromptAlertViewLandscape *)promptWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText;
+ (BlockTextPromptAlertViewLandscape *)promptWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText block:(TextFieldReturnCallBack) block;

+ (BlockTextPromptAlertViewLandscape *)promptWithTitle:(NSString *)title message:(NSString *)message textField:(out UITextField**)textField;

+ (BlockTextPromptAlertViewLandscape *)promptWithTitle:(NSString *)title message:(NSString *)message textField:(out UITextField**)textField block:(TextFieldReturnCallBack) block;


- (id)initWithTitle:(NSString *)title message:(NSString *)message defaultText:(NSString*)defaultText block: (TextFieldReturnCallBack) block;


- (void)setAllowableCharacters:(NSString*)accepted;
- (void)setMaxLength:(NSInteger)max;

@end

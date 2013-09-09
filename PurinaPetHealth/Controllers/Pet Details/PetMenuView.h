//
//  PetMenuView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/7/12.
//
//

#import <UIKit/UIKit.h>

@protocol PetMenuDelegate <NSObject>

- (void) changeView:(int)sender;

@end

@interface PetMenuView : UIView

@property (nonatomic, retain) id<PetMenuDelegate> delegate;
@property (nonatomic, retain) UIButton* btnIdentification;
@property (nonatomic, retain) UIButton* btnMedical;
@property (nonatomic, retain) UIButton* btnAppt;

@end

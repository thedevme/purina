//
//  PetInfoView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/6/12.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Pet.h"
#import "AvatarPickerPlus.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "AddContactViewController.h"

@class PetData;

@protocol PetInfoDelegate <NSObject>
- (void) editPet:(PetData *)pet;
@end


@interface PetInfoView : UIView


@property (nonatomic, retain) PetData* objPetData;

//Labels
@property (nonatomic, retain) UILabel* lblPetName;
@property (nonatomic, retain) UILabel* lblGender;
@property (nonatomic, retain) UILabel* lblBirthday;
@property (nonatomic, retain) UILabel* lblAge;
@property (nonatomic, retain) UILabel* lblBreed;
@property (nonatomic, retain) UIButton* btnUpdate;
@property (nonatomic, retain) UIButton* btnShare;
@property (nonatomic, retain) UIButton* btnEdit;
@property (nonatomic, retain) UIImageView *backingViewForRoundedCorner;
@property (nonatomic, assign) id<PetInfoDelegate> delegate;

@property (nonatomic, retain) UIButton *avatar;

- (id)initWithData:(PetData *)data;
- (void) updatePhoto:(UIImage *)avatar;

@end

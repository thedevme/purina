//
//  PetItemView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/23/12.
//
//

#import <UIKit/UIKit.h>
#import "Pet.h"

@protocol PetListDelegate <NSObject>

@required
- (void) selectedPet:(Pet *)pet;
- (void) deselectedPet:(Pet *)pet;
@end

@interface PetItemView : UIView
{
    __unsafe_unretained id<PetListDelegate> delegate;
}

@property (nonatomic, assign) id delegate;

@property (assign) BOOL isItemSelected;
@property (nonatomic, retain) Pet* objPet;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckMark;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

- (IBAction)onItemTapped:(id)sender;
@end

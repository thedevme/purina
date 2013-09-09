//
//  PetTipsViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/26/12.
//
//

#import <UIKit/UIKit.h>
#import "TipsViewController.h"
#import "PurinaItemButton.h"


@interface PetTipsViewController : UIViewController

- (IBAction) onDogTipsTapped:(id)sender;
- (IBAction) onCatTipsTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgMenu;
@end

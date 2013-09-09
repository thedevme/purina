//
//  HomeModView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/28/12.
//
//


#import <UIKit/UIKit.h>
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "HomeTipCell.h"
#import "Flurry.h"

@protocol HomeModDelegate <NSObject>

- (void) updateView:(NSInteger)tab;

@end

@interface HomeModView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblLiveBlog;
@property (nonatomic, retain) id <HomeModDelegate> delegate;

- (IBAction)onTipsTapped:(id)sender;
- (IBAction)onPetsTapped:(id)sender;

@end

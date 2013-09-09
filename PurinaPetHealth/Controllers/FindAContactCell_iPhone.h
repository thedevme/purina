//
//  FindAContactCell_iPhone.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/27/12.
//
//

#import <UIKit/UIKit.h>

#import "ContactData.h"

@protocol FindContactDelegate <NSObject>

@required
- (void) addContact:(ContactData *)contact;
@end

@interface FindAContactCell_iPhone : UITableViewCell
{
}


@property (strong, nonatomic) IBOutlet UILabel *lblBusinessName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblMiles;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (nonatomic, retain) ContactData* objContactData;
@property (nonatomic, weak) id <FindContactDelegate> delegate;


@property (strong, nonatomic) IBOutlet UIImageView *imgStar;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow;

//@property(nonatomic, strong) UILabel *lblTest;

@property(nonatomic) BOOL isAddVisible;

- (IBAction)onAddTapped:(id)sender;

@end

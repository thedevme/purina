//
// Created by craigclayton on 12/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class ContactData;

@protocol FindContactDelegate_iPad <NSObject>

@required
- (void) addContact:(ContactData *)contact;
@end

@interface FindAContactCell_iPad : UITableViewCell
{
}


@property (strong, nonatomic) IBOutlet UILabel *lblBusinessName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblMiles;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (nonatomic, retain) ContactData* objContactData;
@property (nonatomic, weak) id <FindContactDelegate_iPad> delegate;


@property (strong, nonatomic) IBOutlet UIImageView *imgStar;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow;

//@property(nonatomic, strong) UILabel *lblTest;

@property(nonatomic) BOOL isAddVisible;

- (IBAction)onAddTapped:(id)sender;


@end

//
//  AddVetViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/30/12.
//
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "ContactData.h"
#import "Contact.h"
#import "BlockAlertView.h"
#import "AFJSONRequestOperation.h"
#import "AFURLConnectionOperation.h"
#import "UILabel+ESAdjustableLabel.h"
#import "UniqueID.h"
#import "AFHTTPRequestOperation.h"
#import "NSURL+PathParameters.h"
#import "TTTAttributedLabel.h"
#import "FindContactViewController.h"
#import "FindAContactCell.h"
#import "THMultiPartLabel.h"
#import "OHAttributedLabel.h"
#import "UIColor+PetHealth.h"


@protocol AddContactDelegate <NSObject>

@required
- (void) addContactData:(ContactData *)contact;
@end



@class TPKeyboardAvoidingScrollView;

@interface AddContactViewController : UIViewController  <UITextFieldDelegate, TTTAttributedLabelDelegate, FindContactViewDelegate>

@property (nonatomic, retain) ContactData* objContactData;
@property(nonatomic, retain) IBOutlet OHAttributedLabel* lblTitle;
@property(nonatomic, retain) IBOutlet OHAttributedLabel* lblDesc;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitlePhone;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleZip;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleCity;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleState;

@property (nonatomic, weak) id <AddContactDelegate> delegate;

@property (assign) BOOL * isEditable;

@property (nonatomic, retain) FindContactViewController* findContactView;

@property (nonatomic, retain) NSString* type;

@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
//@property (nonatomic, retain) AFURLConnectionOperation* op;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic) TTTAttributedLabel *attributedLabel;

- (void) updateContactForm:(ContactData *)data;
- (IBAction)onFindTapped:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)type;


@end
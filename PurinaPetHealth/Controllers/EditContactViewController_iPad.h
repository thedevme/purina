//
//  EditContactViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/29/12.
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
#import "FindContactViewController_iPad.h"
#import "FindAContactCell_iPad.h"
#import "THMultiPartLabel.h"
#import "OHAttributedLabel.h"
#import "UIColor+PetHealth.h"
#import "PurinaItemButton.h"


@class TPKeyboardAvoidingScrollView;

@protocol EditContactDelegate <NSObject>

@required
- (void) saveContact:(ContactData *)contact;
@end

@interface EditContactViewController_iPad : UIViewController  <UITextFieldDelegate, TTTAttributedLabelDelegate, FindContactDelegate, FindContactViewDelegate_iPad>

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
@property (nonatomic, weak) id <EditContactDelegate> delegate;

@property (nonatomic, retain) FindContactViewController_iPad* findContactView;

@property (nonatomic, retain) NSString* type;
@property (assign) BOOL isEmergencyContact;
@property (assign) BOOL isEditable;

@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
//@property (nonatomic, retain) AFURLConnectionOperation* op;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic) TTTAttributedLabel *attributedLabel;
- (IBAction)onFindTapped:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSString *)type;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andContactData:(ContactData *)contact;
- (void) updateContactForm:(ContactData *)data;

@end

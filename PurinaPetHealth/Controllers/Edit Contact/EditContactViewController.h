//
//  EditContactViewController.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/11/12.
//
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import "CoreDataStack.h"
#import "ContactData.h"
#import "BlockAlertView.h"
#import "UILabel+ESAdjustableLabel.h"
#import "UniqueID.h"


@class TPKeyboardAvoidingScrollView;

@interface EditContactViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) Contact* objContact;
@property (nonatomic, retain) CoreDataStack* dataStack;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtWebsite;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleName;
@property (weak, nonatomic) IBOutlet UILabel *lblTitlePhone;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleCity;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleZip;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleEmail;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contactData:(Contact *)data;

@end

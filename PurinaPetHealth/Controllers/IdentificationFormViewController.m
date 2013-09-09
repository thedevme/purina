//
//  IdentificationFormViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import "IdentificationFormViewController.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "PetData.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ApptDatePickerViewController.h"
#import "DateOwnedPicker.h"

@interface IdentificationFormViewController ()

@end

@implementation IdentificationFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tfEyeColor setReturnKeyType:UIReturnKeyDone];
    [self.tfWeight setReturnKeyType:UIReturnKeyDone];
    [self.tfChipNo addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfCoatMarkings addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfColor addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfLicenseNo addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfPedigree addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfPrice addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.tfTagNo addTarget:self
                            action:@selector(textFieldFinished:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];


    self.tfWeight.delegate = self;
    self.tfPrice.delegate = self;
    [self createNavButtons];
    [self setLabels];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
    [self.selectedTf resignFirstResponder];
}




-(void)dismissKeyboard
{
    [self.selectedTf resignFirstResponder];
}

- (void)setData:(PetData *)pet
{
    self.objPetData = pet;

    if ([self.objPetData.species isEqualToString:@"Male"]) self.lblNeutered.text = @"Neutered";
    else self.lblNeutered.text = @"Spayed";

    if (![self.objPetData.weight isEqualToString:@"NA"]) self.tfWeight.text = self.objPetData.weight;
    if (![self.objPetData.color isEqualToString:@"NA"]) self.tfColor.text = self.objPetData.color;
    if (![self.objPetData.eyeColor isEqualToString:@"NA"]) [self.tfEyeColor setText:self.objPetData.eyeColor];
    if (![self.objPetData.coatMarkings isEqualToString:@"NA"]) self.tfCoatMarkings.text = self.objPetData.coatMarkings;
    if (![self.objPetData.price isEqualToString:@"NA"]) self.tfPrice.text = self.objPetData.price;
    if (![self.objPetData.tagNo isEqualToString:@"NA"]) self.tfTagNo.text = self.objPetData.tagNo;
    if (![self.objPetData.chipNo isEqualToString:@"NA"]) self.tfChipNo.text = self.objPetData.chipNo;
    if (![self.objPetData.licenseNo isEqualToString:@"NA"]) self.tfLicenseNo.text = self.objPetData.licenseNo;
    if (![self.objPetData.pedigree isEqualToString:@"NA"]) self.tfPedigree.text = self.objPetData.pedigree;
    //if (![self.objPetData.owned isEqualToString:@"NA"]) self.tfOw.text = owned;

    if ([self.objPetData.spayedNeutered isEqualToString:@"No"])
    {
        self.imgNo.alpha = 1.0f;
        self.imgYes.alpha = 0.0f;
    }
    else
    {
        self.imgNo.alpha = 0.0f;
        self.imgYes.alpha = 1.0f;
    }

    NSLog(@"spayed %@", self.objPetData.spayedNeutered);
}

- (IBAction)onOwnedTapped:(id)sender
{

    [self.view resignFirstResponder];

    DateOwnedPicker *addContactView = [DateOwnedPicker new];
    addContactView.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addContactView];

    addContactView.contentSizeForViewInPopover = CGSizeMake(320, 216);

    if(self.contactPopover == nil)
    {
        self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    }


    addContactView.view.superview.frame = CGRectMake(0, 0, 320, 216);
    self.contactPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [self.contactPopover presentPopoverFromRect:self.btnOwned.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];

    NSLog(@"%@", self.selectedTf);
}

-(BOOL) findAndResignFirstResponder:(UIView *)theView{
    if([theView isFirstResponder]){
        [theView resignFirstResponder];
        return YES;
    }
    for(UIView *subView in theView.subviews){
        if([self findAndResignFirstResponder:subView]){
            return YES;
        }
    }
    return NO;
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//
//
//// My comment : If you have several text controls copy/paste/modify a block above and you are DONE!
//}


- (void)updateSelectedDate:(NSString *)date
{
    NSLog(@"date owned %@", date);

    self.lblOwnedValue.text = date;
}

- (void) createNavButtons
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                 target:self
                                 action:@selector(dismissView:)];


    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.tfColor.leftView = paddingView;
    self.tfColor.leftViewMode = UITextFieldViewModeAlways;
}

- (void) setLabels
{
    self.tfChipNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblChipNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfColor.textColor = [UIColor purinaDarkGrey];
    self.lblColor.textColor = [UIColor purinaDarkGrey];
    self.lblColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfEyeColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblEyeColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfCoatMarkings.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblCoatMarkings.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfPrice.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfPrice.textColor = [UIColor purinaDarkGrey];
    self.lblPrice.textColor = [UIColor purinaDarkGrey];
    self.lblPrice.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfTagNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTagNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfLicenseNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblLicenseNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfPedigree.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfPedigree.textColor = [UIColor purinaDarkGrey];
    self.lblPedigree.textColor = [UIColor purinaDarkGrey];
    self.lblPedigree.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.tfWeight.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.tfWeight.textColor = [UIColor purinaDarkGrey];
    self.lblWeight.textColor = [UIColor purinaDarkGrey];
    self.lblWeight.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblOwnedSince.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    self.lblOwnedSince.textColor = [UIColor purinaDarkGrey];

    self.lblNeutered.textColor = [UIColor purinaDarkGrey];
    self.lblNeutered.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblNo.textColor = [UIColor purinaDarkGrey];
    self.lblNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblYes.textColor = [UIColor purinaDarkGrey];
    self.lblYes.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

    self.lblOwnedValue.textColor = [UIColor purinaDarkGrey];
    self.lblOwnedValue.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];

}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.selectedTf = textField;
    
    if (self.selectedTf == self.tfColor) {
        [self.tfChipNo becomeFirstResponder];
    }
    
    else if (self.selectedTf == self.tfChipNo) {
        [self.tfEyeColor becomeFirstResponder];
    }
    
    else if (self.selectedTf == self.tfEyeColor) {
        [self.tfLicenseNo becomeFirstResponder];
    }
    
    else if (self.selectedTf == self.tfCoatMarkings) {
        [self.tfPedigree becomeFirstResponder];
    }
    else if (self.selectedTf == self.tfPedigree) {
        [self.tfPrice becomeFirstResponder];
    }
    else if (self.selectedTf == self.tfPrice) {
        [self.tfWeight becomeFirstResponder];
    }
    else if (self.selectedTf == self.tfWeight) {
        [self.tfTagNo becomeFirstResponder];
    }
    else{
        [self.selectedTf resignFirstResponder];
    }
    
    
    return YES;
}

- (void)saveData:(id)sender
{

}

- (void)dismissView:(id)sender
{
    [self.delegate didDismissModalView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setTfColor:nil];
    [self setTfEyeColor:nil];
    [self setTfCoatMarkings:nil];
    [self setTfPrice:nil];
    [self setTfTagNo:nil];
    [self setTfChipNo:nil];
    [self setTfLicenseNo:nil];
    [self setTfPedigree:nil];
    [self setLblOwnedSince:nil];
    [self setBtnSave:nil];
    [self setTfWeight:nil];
    [self setLblColor:nil];
    [self setLblEyeColor:nil];
    [self setLblCoatMarkings:nil];
    [self setLblPrice:nil];
    [self setLblTagNo:nil];
    [self setLblChipNo:nil];
    [self setLblLicenseNo:nil];
    [self setLblPedigree:nil];
    [self setLblWeight:nil];
    [self setScrollView:nil];
    [self setLblNeutered:nil];
    [self setLblNo:nil];
    [self setLblYes:nil];
    [self setBtnOwned:nil];
    [self setLblOwnedValue:nil];
    [self setImgNo:nil];
    [self setImgYes:nil];
    [super viewDidUnload];
}
- (IBAction)onSaveTapped:(id)sender
{
    if (![self.tfChipNo.text isEqualToString:@""] || ![self.tfChipNo.text isEqualToString:self.objPetData.chipNo]) self.objPetData.chipNo = self.tfChipNo.text;
    if (![self.tfCoatMarkings.text isEqualToString:@""] || ![self.tfCoatMarkings.text isEqualToString:self.objPetData.coatMarkings]) self.objPetData.coatMarkings = self.tfCoatMarkings.text;
    if (![self.tfLicenseNo.text isEqualToString:@""] || ![self.tfLicenseNo.text isEqualToString:self.objPetData.licenseNo]) self.objPetData.licenseNo = self.tfLicenseNo.text;
    if (![self.tfPedigree.text isEqualToString:@""] || ![self.tfPedigree.text isEqualToString:self.objPetData.pedigree]) self.objPetData.pedigree = self.tfPedigree.text;
    if (![self.tfTagNo.text isEqualToString:@""] || ![self.tfTagNo.text isEqualToString:self.objPetData.tagNo]) self.objPetData.tagNo = self.tfTagNo.text;
    if (![self.tfColor.text isEqualToString:@""] || ![self.tfColor.text isEqualToString:self.objPetData.color]) self.objPetData.color = self.tfColor.text;
    if (![self.tfEyeColor.text isEqualToString:@""] || ![self.tfEyeColor.text isEqualToString:self.objPetData.eyeColor]) self.objPetData.eyeColor = self.tfEyeColor.text;
    if (![self.tfPrice.text isEqualToString:@""] || ![self.tfPrice.text isEqualToString:self.objPetData.price]) self.objPetData.price = self.tfPrice.text;
    if (![self.tfWeight.text isEqualToString:@""] || ![self.tfWeight.text isEqualToString:self.objPetData.weight]) self.objPetData.weight = self.tfWeight.text;
    if (![self.lblOwnedValue.text isEqualToString:@""] || ![self.lblOwnedValue.text isEqualToString:self.objPetData.owned]) self.objPetData.owned = self.lblOwnedValue.text;

    NSLog(@"save date owned: %@", self.objPetData.owned);

    [self.delegate saveIdentificationData:self.objPetData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.selectedTf = textField;


}


- (IBAction)onYesNoTapped:(id)sender
{
    if ([sender tag] == 0)
    {
        self.imgNo.alpha = 1.0f;
        self.imgYes.alpha = 0.0f;
        self.objPetData.spayedNeutered = @"No";
    }
    else
    {
        self.imgNo.alpha = 0.0f;
        self.imgYes.alpha = 1.0f;
        self.objPetData.spayedNeutered = @"Yes";
    }
}


@end

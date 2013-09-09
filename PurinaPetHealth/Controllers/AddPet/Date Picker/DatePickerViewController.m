//
//  DatePickerViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//   

#import "DatePickerViewController.h"
#import "NSDate+Helper.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
@synthesize pickerDate;
@synthesize lblBirthdate;
@synthesize birthdayDate = _birthdayDate;
@synthesize birthdayDisplayDate = _birthdayDisplayDate;
@synthesize objBirthdayData;
@synthesize lblBirthday, lblPlease, lblYour;
@synthesize switchReminder;

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
    
    objBirthdayData = [[BirthdayData alloc] init];
    [self createNavigationButtons];
    [self setDatePicker];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPickerDate:nil];
    [self setLblBirthdate:nil];
    [self setLblPlease:nil];
    [self setLblYour:nil];
    [self setLblBirthday:nil];
    [self setSwitchReminder:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) createNavigationButtons
{
    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonSystemItemDone target:self action:@selector(onSaveTapped:)];
    btnDoneItem.tintColor = [UIColor colorWithRed:145.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItem = btnDoneItem;
}

- (void) setDatePicker
{
    
    NSDate* today = [NSDate date];
    pickerDate.maximumDate = today;
    lblBirthdate.text = NSLocalizedString(@"TODAY", nil);
    [self updateDate];
}

- (void) updateDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    self.birthdayDate = [NSDate formatDate:pickerDate.date formatType:@"MM-dd-yyyy"];
    
	[df setDateStyle:NSDateFormatterLongStyle];
	[df setTimeStyle:NSDateFormatterNoStyle];
    //NSLog(@"date %@", [NSDate formatDate:pickerDate.date formatType:@"MMMM dd, yyyy"]);
	self.birthdayDisplayDate = [NSString stringWithFormat:@"%@", [df stringFromDate:pickerDate.date]];
    
    
    NSDate* today = [NSDate date];
    
    if ([NSDate isSameDay:pickerDate.date otherDay:today])
    {
        lblBirthdate.text = NSLocalizedString(@"TODAY", nil);
    }
    else
    {
        lblBirthdate.text = [NSDate formatDate:pickerDate.date formatType:@"MMMM dd, yyyy"];
    }
    
    
    
    if (![lblBirthdate.text isEqualToString:NSLocalizedString(@"TODAY", nil)]) 
    lblBirthdate.textColor = [UIColor blackColor];
    
    lblPlease.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:27.0f];
    lblPlease.textColor = [UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:255/255.f];
    
    lblYour.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:27.0f];
    lblYour.textColor = [UIColor colorWithRed:205/255.f green:1/255.f blue:1/255.f alpha:255/255.f];
    
    lblBirthday.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:32.0f];
    lblBirthday.textColor = [UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:255/255.f];
    
    
    
    
    
    
    //NSLog(@"date: %@ start date short: %@", self.birthdayDisplayDate, self.birthdayDate);
    
    objBirthdayData.birthdayDate = pickerDate.date;
    objBirthdayData.birthdayDisplayDate = self.birthdayDisplayDate;
    if (switchReminder.on) objBirthdayData.isReminderSet = YES;
    else objBirthdayData.isReminderSet = NO;
    
    //lblDate.text = [NSDate determineDate:pickerDate.date];
}

- (IBAction)changeDate:(id)sender 
{
    [self updateDate];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)onReminderTapped:(id)sender {
}

- (IBAction)onCancelTapped:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSaveTapped:(id)sender
{
    //NSLog(@"save date: %@ start date short: %@", objBirthdayData.birthdayDisplayDate, objBirthdayData.birthdayDate);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"birthdaySet" object:objBirthdayData];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate dateSelected:objBirthdayData];
    //[self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{

    CGSize size = CGSizeMake(320, 480); // size of view in popover
    self.contentSizeForViewInPopover = size;

    [super viewWillAppear:animated];

}


@end

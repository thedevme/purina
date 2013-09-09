//
//  ApptDatePickerViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import "ApptDatePickerViewController.h"
#import "NSDate+Helper.h"

@interface ApptDatePickerViewController ()

@end

@implementation ApptDatePickerViewController

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
    [self setDatePicker];
    [self createToolbar];
    [self updateDate];
}

- (void)createToolbar {
    CGFloat toolbarHeight = 40;
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, toolbarHeight)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;

    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:)];
    UIBarButtonItem* spacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];

    [toolbar setItems:[NSArray arrayWithObjects:done, spacing, cancel, nil]];
    [self.view addSubview:toolbar];
}

- (void) onCancel:(id)sender
{
    [self.delegate dismissDate];
}

- (void) onDone:(id)sender
{
//    if (self.selectedDate.length == 0)
//    {
//        NSDateFormatter *df = [[NSDateFormatter alloc] init];
//
//
//        [df setDateStyle:NSDateFormatterLongStyle];
//        [df setTimeStyle:NSDateFormatterNoStyle];
//
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setDateFormat:@"h:mm a"];
//        NSString *dateString = [outputFormatter stringFromDate:[NSDate date]];
//
//        NSString *birthdate = [NSString stringWithFormat:@"%@, %@", [NSDate formatDate:[NSDate date] formatType:@"MM/dd/yyyy"], dateString];
//        self.selectedDate = birthdate;
//
//    }
//
//
//    NSLog(@"selected %@", self.selectedDate);

    [self.delegate doneWithSelectedDate:self.selectedDate andDate:self.pickerDate.date];
}


- (void) setDatePicker
{

    NSDate* today = [NSDate date];
    self.pickerDate.minimumDate = today;
    self.lblBirthdate.text = NSLocalizedString(@"TODAY", nil);
    [self updateDate];
}

- (void) updateDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];


    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"]; //24hr time format
    NSString *dateString = [outputFormatter stringFromDate:self.pickerDate.date];
    NSLog(@"%@", dateString);

    NSDate* today = [NSDate date];

    NSString *birthdate = [NSString stringWithFormat:@"%@, %@", [NSDate formatDate:self.pickerDate.date formatType:@"MM/dd/yyyy"], dateString];

    if ([NSDate isSameDay:self.pickerDate.date otherDay:today])
    {
        self.lblBirthdate.text = NSLocalizedString(@"TODAY", nil);
        self.selectedDate = birthdate;
    }
    else
    {
        self.selectedDate = birthdate;
        self.lblBirthdate.text = birthdate;
    }



    if (![self.lblBirthdate.text isEqualToString:NSLocalizedString(@"TODAY", nil)])
        self.lblBirthdate.textColor = [UIColor blackColor];
}

- (IBAction)changeDate:(id)sender
{
    [self updateDate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  DateOwnedPicker.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/24/12.
//
//

#import "DateOwnedPicker.h"
#import "NSDate+Helper.h"

@interface DateOwnedPicker ()

@end

@implementation DateOwnedPicker

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
    [self updateDate];


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDate:(id)sender
{
    [self updateDate];

}

- (void) updateDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];

    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    self.selectedDate = [NSDate formatDate:self.pickerDate.date formatType:@"MMMM dd, yyyy"];
    [self.delegate updateSelectedDate:self.selectedDate];
    //lblDate.text = [NSDate determineDate:pickerDate.date];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

@end

//
//  ApptTypePickerViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import "ApptTypePickerViewController.h"

@interface ApptTypePickerViewController ()

@end

@implementation ApptTypePickerViewController

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
    
    self.apptTypes = [[NSMutableArray alloc] init];
    [self.apptTypes addObject:@"Veterinarian"];
    [self.apptTypes addObject:@"Grooming"];
    [self.apptTypes addObject:@"Vaccination"];
    [self.apptTypes addObject:@"Medication"];
    [self.apptTypes addObject:@"Heartworm Prevention"];
    [self.apptTypes addObject:@"Flea Control"];
    [self.apptTypes addObject:@"Surgery"];
    [self.apptTypes addObject:@"Training"];
    [self.apptTypes addObject:@"Walking/Sitting"];

    [self createToolbar];
    // Do any additional setup after loading the view from its nib.
}

- (void)createToolbar {
    CGFloat toolbarHeight = 40;
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 76, 320, toolbarHeight)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;

    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:)];
    UIBarButtonItem* spacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];

    [toolbar setItems:[NSArray arrayWithObjects:done, spacing, cancel, nil]];
    [self.view addSubview:toolbar];
}

- (void) onCancel:(id)sender
{
    [self.delegate dismissType];
}

- (void) onDone:(id)sender
{
    if (self.selectedType.length == 0) self.selectedType = [self.apptTypes objectAtIndex:0];
    [self.delegate doneWithSelectedType:self.selectedType];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.apptTypes count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.apptTypes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.selectedType = [self.apptTypes objectAtIndex:row];
    NSLog(@"Selected Color: %@. Index of selected color: %i", [self.apptTypes objectAtIndex:row], row);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPickerView:nil];
    [self setLblTitle:nil];
    [super viewDidUnload];
}
@end

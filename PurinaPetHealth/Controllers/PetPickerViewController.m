//
//  PetPickerViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/25/12.
//
//

#import "PetPickerViewController.h"
#import "PetModel.h"
#import "UIViewController+KNSemiModal.h"

@interface PetPickerViewController ()

@end

@implementation PetPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"init with pet picker");

        //
        self.petNames = [[NSMutableArray alloc] init];
        self.petIds = [[NSMutableArray alloc] init];
        self.selectedPets = [[NSMutableArray alloc] init];
        self.selectedPetsData = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.petModel = [[PetModel alloc] init];


    NSArray *arrPets = [[NSArray alloc] initWithArray:[self.petModel getPetData]];
    self.petData = [[NSMutableArray alloc] initWithArray:arrPets];




    for (int i = 0; i < [arrPets count]; i++)
    {
        [self.petNames addObject:[[arrPets objectAtIndex:i] name]];
        [self.petIds addObject:[[arrPets objectAtIndex:i] guid]];
    }


    self.selectionStates = [[NSMutableDictionary alloc] init];
	for (NSString *key in self.petNames)
		[self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	
	// Init picker and add it to view
    CGFloat toolbarHeight = 40;
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 225, 320, toolbarHeight)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onCancel:)];
    UIBarButtonItem* spacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:done, spacing, cancel, nil]];
     [self.view addSubview:toolbar];
    
	self.pickerView = [[ALPickerView alloc] initWithFrame:CGRectMake(0, 265, 0, 0)];
    self.pickerView.delegate = self;
    self.pickerView.allOptionTitle = nil;
	[self.view addSubview:self.pickerView];


    for (int j = 0; j < self.selectedPetsData.count; j++)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [[self.selectedPetsData objectAtIndex:j] guid]];
        [self.selectedPets addObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];
        [self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[self.petNames objectAtIndex:j]];
    }

	// Do any additional setup after loading the view.
}

- (void) onCancel:(id)sender
{
    [self.delegate dismiss];
}

- (void) onDone:(id)sender
{
    [self.delegate doneWithPets:self.selectedPets];
}

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView {
	return [self.petNames count];
}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row {
	return [self.petNames objectAtIndex:row];
}

- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row
{


	return [[self.selectionStates objectForKey:[self.petNames objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [self.petIds objectAtIndex:row]];
    [self.selectedPets addObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];

    if (row == -1)
		for (id key in [self.selectionStates allKeys])
			[self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[self.petNames objectAtIndex:row]];
}



- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [self.petIds objectAtIndex:row]];
    [self.selectedPets removeObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];

    if (row == -1)
		for (id key in [self.selectionStates allKeys])
			[self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[self.petNames objectAtIndex:row]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MyPetsViewController.m
//  PurinaHealth
//
//  Created by Craig Clayton on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyPetsViewController.h"
#import "NSDate+Helper.h"
#import "PetModel.h"
#import "PetData.h"
#import "OHASBasicMarkupParser.h"

@interface MyPetsViewController ()

@end

@implementation MyPetsViewController

@synthesize tableView;
@synthesize dataStack = _dataStack;
@synthesize pets = _pets;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"My Pets";
        self.navigationItem.title = @"My Pets";

        self.petModel = [[PetModel alloc] init];
        self.tabBarItem.image = [UIImage imageNamed:@"tabIcon_paw.png"];
        //self.pets = [[NSMutableArray alloc] init];


    }
    return self;
}


- (void) createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:30]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"pets"]];

    self.lblMessage.alpha = 1.0f;
    self.lblMessage.attributedText = attrStr;
}





- (void) createModel
{
    self.dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    self.dataStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;



    //[self getPetData];
    
    NSDate* today = [NSDate date];
    NSDate* normalize;
    normalize = [NSDate normalizedDateWithDate:today];
    
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    UIBarButtonItem *btnDoneItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIButtonTypeCustom target:self action:@selector(onAddTapped:)];
    [btnDoneItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:btnDoneItem];
    
}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(savePet:) name:@"savePet" object:nil];
}

//- (void) getPetData
//{
//    NSError* error = nil;
//    NSEntityDescription *entityDescription = [NSEntityDescription
//                                              entityForName:@"Pet"
//                                              inManagedObjectContext:self.dataStack.managedObjectContext];
//
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    [request setEntity:entityDescription];
//    NSArray *array = [self.dataStack.managedObjectContext executeFetchRequest:request error:&error];
//
//
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateAdded" ascending:NO];
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//
//    NSMutableArray* arrPetsData = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingDescriptors:sortDescriptors]];
//
//    self.petNames = arrPetsData;
//}

- (void) getPetByID
{
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pets.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifer";
    MyPetCell* cell = (MyPetCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MyPetCell" owner:self options:nil];
    PetData* objPet = [self.pets objectAtIndex:indexPath.row];
    
    
    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
    cell.lblPetName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f];
    cell.lblTitleBirthday.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
    cell.lblTitleBreed.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
    cell.lblBirthday.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    cell.lblBreed.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    cell.lblTitleBreed.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
    cell.lblPetName.text = [objPet name];
    //NSDate* birthdayDisplay = [objPetData birthday];
    
    if (objPet.imageData == NULL)
    {
        cell.imgBorder.image = [UIImage imageNamed:@"defaultPetIcon@2x.png"];
    }
    else
    {
        cell.imgBorder.image = [UIImage imageWithData:objPet.imageData];
    }
    //UIImage* image = [UIImage imageWithData:selectedDance.danceImage];
    //UIImage *image = [UIImage imageWithData:[[objPetData image] valueForKey:@"image"]];
    //NSLog(@"%@", [objPetData image]);
    //[cell.imgBorder setImage:imageData];
    if ([objPet breed] != NULL) cell.lblBreed.text = [objPet breed];
    
    NSLog(@"guid %@", [objPet guid]);
    if ([objPet.birthday isEqualToString:@"NA"]) cell.lblBirthday.text = NSLocalizedString(@"Not Set", nil);
    else cell.lblBirthday.text = [objPet birthday];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (void) savePet:(NSNotification *)note
{
    //[self getPetData];
    NSLog(@"PLEASE UPDATE SAVE PET");
    [self.pets removeAllObjects];
    self.pets = [[NSMutableArray alloc] initWithArray:[self.petModel getPetData]];
    [tableView reloadData];

    if (self.pets.count == 0)
    {
        [self createMessage:@"You currently\n have no pets added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableView setContentInset:UIEdgeInsetsMake(10,0,0,0)];
    //[self createModel];


    [self createNavigationButtons];
    [self addObservers];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self getPetData];
    self.pets = [[NSMutableArray alloc] initWithArray:[self.petModel getPetData]];
    [self.tableView reloadData];

    if (self.pets.count == 0)
    {
        [self createMessage:@"You currently\n have no pets added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }


    NSLog(@"There are %i total pets", self.pets.count);
}

- (void)viewDidUnload
{
    [self setLblMessage:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)onAddTapped:(id)sender
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        AddPetViewController_iPhone5* addPetsViewController = [[AddPetViewController_iPhone5 alloc] initWithNibName:@"AddPetViewController_iPhone5" bundle:nil];
        //[self.navigationController setNavigationBarHidden:NO];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPetsViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_ADDAPET"];
    }
    else
    {
        AddPetViewController* addPetsViewController = [[AddPetViewController alloc] initWithNibName:@"AddPetViewController" bundle:nil];
        addPetsViewController.delegate = self;
        //[self.navigationController setNavigationBarHidden:NO];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addPetsViewController];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self presentModalViewController:navController animated:YES];
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_ADDAPET"];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        PetDetailsViewController_iPhone5* petDetails = [[PetDetailsViewController_iPhone5 alloc] initWithNibName:@"PetDetailsViewController_iPhone5" bundle:nil];
        //petDetails.dataStack = self.dataStack;

        petDetails.delegate = self;
        NSLog(@"contacts %@", [[self.pets objectAtIndex:[indexPath row]] contacts]);
        petDetails.objPetData = [self.pets objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:petDetails animated:YES];
    }
    else
    {
        PetDetailsViewController* petDetails = [[PetDetailsViewController alloc] initWithNibName:@"PetDetailsViewController" bundle:nil];

        petDetails.delegate = self;
        NSLog(@"contacts %@", [[self.pets objectAtIndex:[indexPath row]] contacts]);
        petDetails.objPetData = [self.pets objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:petDetails animated:YES];
    }
}

- (void)newPetAdded
{
    [self.pets removeAllObjects];
    self.pets = [[NSMutableArray alloc] initWithArray:[self.petModel getPetData]];
    [self.tableView reloadData];

    if (self.pets.count == 0)
    {
        [self createMessage:@"You currently\n have no pets added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
}

- (void) updatePetList
{
    NSLog(@"updatelist");
    [self.pets removeAllObjects];
    self.pets = [[NSMutableArray alloc] initWithArray:[self.petModel getPetData]];
    [self.tableView reloadData];


    if (self.pets.count == 0)
    {
        [self createMessage:@"You currently\n have no pets added."];
    }
    else
    {
        self.lblMessage.alpha = 0.0f;
    }
}


@end

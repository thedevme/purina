//
//  PetListViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 10/18/12.
//
//

#import "PetListViewController.h"

@interface PetListViewController ()

@end

@implementation PetListViewController

@synthesize arrPets, arrSelectedPets;

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
    [self initialize];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) initialize
{
    [self setData];
    [self createPetList];
}

- (void) setData
{
    arrPets = [[NSMutableArray alloc] initWithArray:[Pet getPetData]];
    arrSelectedPets = [[NSMutableArray alloc] init];
}

- (void) createPetList
{
    for (int i = 0; i < [arrPets count]; i++)
    {
        PetItemView* item = [[PetItemView alloc] init];
        item = [[[NSBundle mainBundle] loadNibNamed:@"PetItemView" owner:self options:nil] objectAtIndex:0];
        item.delegate = self;
        item.objPet = [arrPets objectAtIndex:i];
        item.lblName.text = [[arrPets objectAtIndex:i] name];
        item.lblName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
        item.frame = CGRectMake(0, 50 * i, 320, 50);
        [self.view addSubview:item];
    }
}

- (void) selectedPet:(Pet *)pet
{
    [arrSelectedPets addObject:pet];
    NSLog(@"%@", arrSelectedPets);
}

- (void) deselectedPet:(Pet *)pet
{
    [arrSelectedPets removeObject:pet];
    NSLog(@"%@", arrSelectedPets);
}

- (void)itemTapped:(id)sender
{
    NSLog(@"%i", [sender tag]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

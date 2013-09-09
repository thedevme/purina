//
//  ApptPetListViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/5/13.
//
//

#import "ApptPetListViewController.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "PetModel.h"

@interface ApptPetListViewController ()
{
    NSIndexPath* lastIndexPath;
}

@end

@implementation ApptPetListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        self.arrSelectedPets = [[NSMutableArray alloc] init];
        self.arrPets = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];

    self.tableView.backgroundView = tempImageView;

    self.petModel = [[PetModel alloc] init];


    NSArray *arrPets = [[NSArray alloc] initWithArray:[self.petModel getPetData]];
    self.petData = [[NSMutableArray alloc] initWithArray:arrPets];
    self.petNames = [[NSMutableArray alloc] init];
    self.petIds = [[NSMutableArray alloc] init];
    self.selectedPets = [[NSMutableArray alloc] init];



    for (int i = 0; i < [arrPets count]; i++)
    {
        [self.petNames addObject:[[arrPets objectAtIndex:i] name]];
        [self.petIds addObject:[[arrPets objectAtIndex:i] guid]];
    }

    self.selectionStates = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.petNames)
        [self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];

    [self createNavigationButtons];
}

- (void) createNavigationButtons
{
    UIImage *btnBackground = [[UIImage imageNamed:@"btnSmallRed.png"]
            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem *btnCancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIButtonTypeCustom target:self action:@selector(onCancelTapped:)];
        [btnCancelItem setBackgroundImage:btnBackground forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:btnCancelItem];
    }
}

- (void) onCancelTapped:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.petNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTableIdentifier";

    TipCategoryCell *cell = (TipCategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TipCategoryCell" owner:self options:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (cell == nil)
    {
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    cell.name.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
    cell.name.textColor = [UIColor purinaDarkGrey];
    cell.name.text = [self.petNames objectAtIndex:[indexPath row]];


    for (int j = 0; j < self.arrSelectedPets.count; j++)
    {

        //NSUInteger index = [self.petNames indexOfObject:[[self.arrSelectedPets objectAtIndex:j] name]];
        //NSLog(@"%@ pos %d", [[self.arrSelectedPets objectAtIndex:j] name], index);

        if ([cell.name.text isEqualToString:[[self.arrSelectedPets objectAtIndex:j] name]])
        {
            cell.imgSelected.alpha = 1.0f;
            lastIndexPath = indexPath;

            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [[self.arrSelectedPets objectAtIndex:j] guid]];
            [self.selectedPets addObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];
            [self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[self.petNames objectAtIndex:indexPath.row]];
        }
    }

    //NSString *name = [[self.arrSelectedPets objectAtIndex:indexPath.row] name];



    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TipCategoryCell* newCell = (TipCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;

    if (newCell.imgSelected.alpha == 0)
    {
        newCell.imgSelected.alpha = 1.0f;
        //[self.arrSelectedPets addObject:[NSNumber numberWithInt:indexPath.row]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [self.petIds objectAtIndex:indexPath.row]];
        [self.selectedPets addObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];

        if (indexPath.row == -1)
            for (id key in [self.selectionStates allKeys])
                [self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
        else
            [self.selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[self.petNames objectAtIndex:indexPath.row]];


    }
    else
    {
        newCell.imgSelected.alpha = 0.0f;

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"guid == %@", [self.petIds objectAtIndex:indexPath.row]];
        [self.selectedPets removeObject:[[self.petData filteredArrayUsingPredicate:predicate] lastObject]];

        if (indexPath.row == -1)
            for (id key in [self.selectionStates allKeys])
                [self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
        else
            [self.selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[self.petNames objectAtIndex:indexPath.row]];
    }

    [self.delegate selectedApptPets:self.selectedPets];
    //[NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(hideView) userInfo:nil repeats:NO];

}

- (void) hideView
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"cancel tapped complete");
    }];
}

@end


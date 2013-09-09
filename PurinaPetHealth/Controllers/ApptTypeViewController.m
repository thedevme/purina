//
//  ApptTypeViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 1/5/13.
//
//

#import "ApptTypeViewController.h"
#import "TipCategoriesViewController.h"

@interface ApptTypeViewController ()
{
    NSIndexPath* lastIndexPath;
}

@end

@implementation ApptTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        self.arrCategories = [[NSMutableArray alloc] init];

        [self.arrCategories addObject:@"Veterinarian"];
        [self.arrCategories addObject:@"Grooming"];
        [self.arrCategories addObject:@"Vaccination"];
        [self.arrCategories addObject:@"Medication"];
        [self.arrCategories addObject:@"Heartworm Prevention"];
        [self.arrCategories addObject:@"Flea Control"];
        [self.arrCategories addObject:@"Surgery"];
        [self.arrCategories addObject:@"Training"];
        [self.arrCategories addObject:@"Walking/Sitting"];
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSelectedCat:(NSString *)category
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        _strSelectedType = category;
        self.arrCategories = [[NSMutableArray alloc] init];

        [self.arrCategories addObject:@"Veterinarian"];
        [self.arrCategories addObject:@"Grooming"];
        [self.arrCategories addObject:@"Vaccination"];
        [self.arrCategories addObject:@"Medication"];
        [self.arrCategories addObject:@"Heartworm Prevention"];
        [self.arrCategories addObject:@"Flea Control"];
        [self.arrCategories addObject:@"Surgery"];
        [self.arrCategories addObject:@"Training"];
        [self.arrCategories addObject:@"Walking/Sitting"];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];

    self.tableView.backgroundView = tempImageView;

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
    //NSLog(@"cancel tapped");
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
    return [_arrCategories count];
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
    cell.name.text = [_arrCategories objectAtIndex:[indexPath row]];

    if ([cell.name.text isEqualToString:_strSelectedType])
    {
        cell.imgSelected.alpha = 1.0f;
        lastIndexPath = indexPath;
    }

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

    if(newRow != oldRow)
    {
        newCell.imgSelected.alpha = 1.0f;

        TipCategoryCell* oldCell = (TipCategoryCell *)[tableView cellForRowAtIndexPath:lastIndexPath];
        oldCell.imgSelected.alpha = 0.0f;
        lastIndexPath = indexPath;
        _strSelectedType = [_arrCategories objectAtIndex:[indexPath row]];
    }

    [self.delegate selectedType:_strSelectedType];
}

@end
//
//  FindPetFunViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 8/28/12.
//
//

#import "FindPetFunViewController.h"
#import "Constants.h"

@interface FindPetFunViewController ()

@end

@implementation FindPetFunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Find Pet Care";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self checkPhone];
    [self setMenuImage];
}

- (void) checkPhone
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self createiPhone5Buttons];
    }
    else
    {
        [self createButtons];
    }
}

- (void)viewDidUnload
{
    [self setImgMenu:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) setMenuImage
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _imgMenu.frame = CGRectMake(0, 0, 320, 278);
        _imgMenu.image = [UIImage imageNamed:@"lifeDog-568h.png"];
        
    }
    else
    {
        _imgMenu.frame = CGRectMake(0, 0, 320, 187);
        _imgMenu.image = [UIImage imageNamed:@"lifeDog.png"];
    }
}

- (void) createButtons
{
    PurinaItemButton* btnVet = [[PurinaItemButton alloc] init:@"Find a Veterinarian"];
    [btnVet addTarget:self action:@selector(onFindVetTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnVet.frame = CGRectMake(7, 192, 307, 51);
    [self.view addSubview:btnVet];
    
    PurinaItemButton* btnGrommer = [[PurinaItemButton alloc] init:@"Find a Groomer"];
    [btnGrommer addTarget:self action:@selector(onGroomerTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnGrommer.frame = CGRectMake(7, 252, 307, 51);
    [self.view addSubview:btnGrommer];
    
    PurinaItemButton* btnKennel = [[PurinaItemButton alloc] init:@"Find a Kennel"];
    [btnKennel addTarget:self action:@selector(onKennelTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnKennel.frame = CGRectMake(7, 310, 307, 51);
    [self.view addSubview:btnKennel];
}

- (void) createiPhone5Buttons
{
//    PurinaItemButton* btnVet = [[PurinaItemButton alloc] initWithLargeBtn:@"Find a Veterinarian"];
//    [btnVet addTarget:self action:@selector(onFindVetTapped:) forControlEvents:UIControlEventTouchUpInside];
//    btnVet.frame = CGRectMake(7, 200, 307, 65);
//    [self.view addSubview:btnVet];
//    
//    PurinaItemButton* btnGrommer = [[PurinaItemButton alloc] initWithLargeBtn:@"Find a Groomer"];
//    [btnGrommer addTarget:self action:@selector(onGroomerTapped:) forControlEvents:UIControlEventTouchUpInside];
//    btnGrommer.frame = CGRectMake(7, 285, 307, 65);
//    [self.view addSubview:btnGrommer];
//    
//    PurinaItemButton* btnKennel = [[PurinaItemButton alloc] initWithLargeBtn:@"Find a Kennel"];
//    [btnKennel addTarget:self action:@selector(onKennelTapped:) forControlEvents:UIControlEventTouchUpInside];
//    btnKennel.frame = CGRectMake(7, 370, 307, 65);
//    [self.view addSubview:btnKennel];
    
    
    int numStartYPos = 290;
    
    
    PurinaItemButton* btnVet = [[PurinaItemButton alloc] init:@"Find a Veterinarian"];
    [btnVet addTarget:self action:@selector(onFindVetTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnVet.frame = CGRectMake(7, numStartYPos, 307, 51);
    [self.view addSubview:btnVet];
    
    PurinaItemButton* btnGrommer = [[PurinaItemButton alloc] init:@"Find a Groomer"];
    [btnGrommer addTarget:self action:@selector(onGroomerTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnGrommer.frame = CGRectMake(7, numStartYPos + 52, 307, 51);
    [self.view addSubview:btnGrommer];
    
    PurinaItemButton* btnKennel = [[PurinaItemButton alloc] init:@"Find a Kennel"];
    [btnKennel addTarget:self action:@selector(onKennelTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnKennel.frame = CGRectMake(7, numStartYPos + 104, 307, 51);
    [self.view addSubview:btnKennel];
}



- (IBAction)onFindVetTapped:(id)sender
{
    FindContactViewController* findAVetView = [[FindContactViewController alloc] initWithNibName:@"FindContactViewController" bundle:nil withType:kVeterinarian showAdd:NO];
    [self.navigationController pushViewController:findAVetView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_FINDVET"];
}

- (IBAction)onGroomerTapped:(id)sender
{
    FindContactViewController* findAGroomerView = [[FindContactViewController alloc] initWithNibName:@"FindContactViewController" bundle:nil withType:kGroomer showAdd:NO];
    [self.navigationController pushViewController:findAGroomerView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_GROOMER"];
    
}

- (IBAction)onKennelTapped:(id)sender
{
    FindContactViewController* findAKennelView = [[FindContactViewController alloc] initWithNibName:@"FindContactViewController" bundle:nil withType:kKennel showAdd:NO];
    [self.navigationController pushViewController:findAKennelView animated:YES];
    [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_KENNEL"];
}
@end

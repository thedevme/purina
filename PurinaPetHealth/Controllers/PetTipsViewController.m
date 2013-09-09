//
//  PetTipsViewController.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/26/12.
//
//

#import "PetTipsViewController.h"

@interface PetTipsViewController ()

@end

@implementation PetTipsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.title = @"Pet Tips";
    }
    return self;
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

- (void) setMenuImage
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        _imgMenu.frame = CGRectMake(0, 0, 320, 278);
        _imgMenu.image = [UIImage imageNamed:@"lifeCat-568h.png"];
        
    }
    else
    {
        _imgMenu.frame = CGRectMake(0, 0, 320, 187);
        _imgMenu.image = [UIImage imageNamed:@"lifeCat.png"];
    }
}

- (void) createButtons
{
    PurinaItemButton* btnDogTips = [[PurinaItemButton alloc] init:@"Dog Tips"];
    [btnDogTips addTarget:self action:@selector(onDogTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnDogTips.frame = CGRectMake(7, 218, 307, 51);
    [self.view addSubview:btnDogTips];
    
    PurinaItemButton* btnCatTips = [[PurinaItemButton alloc] init:@"Cat Tips"];
    [btnCatTips addTarget:self action:@selector(onCatTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnCatTips.frame = CGRectMake(7, 277, 307, 51);
    [self.view addSubview:btnCatTips];
}

- (void) createiPhone5Buttons
{
    PurinaItemButton* btnDogTips = [[PurinaItemButton alloc] init:@"Dog Tips"];
    [btnDogTips addTarget:self action:@selector(onDogTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnDogTips.frame = CGRectMake(7, 315, 307, 51);
    [self.view addSubview:btnDogTips];
    
    PurinaItemButton* btnCatTips = [[PurinaItemButton alloc] init:@"Cat Tips"];
    [btnCatTips addTarget:self action:@selector(onCatTipsTapped:) forControlEvents:UIControlEventTouchUpInside];
    btnCatTips.frame = CGRectMake(7, 367, 307, 51);
    [self.view addSubview:btnCatTips];
}


- (IBAction) onDogTipsTapped:(id)sender
{
    TipsViewController* tipsContainer = [[TipsViewController alloc] initWithNibName:@"TipsViewController" bundle:nil andTipsType:@"dog"];
    tipsContainer.title = @"Dog Tips";
    [self.navigationController pushViewController:tipsContainer animated:YES];
}

- (IBAction) onCatTipsTapped:(id)sender
{
    TipsViewController* tipsContainer = [[TipsViewController alloc] initWithNibName:@"TipsViewController" bundle:nil andTipsType:@"cat"];
    tipsContainer.title = @"Cat Tips";
    [self.navigationController pushViewController:tipsContainer animated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self checkPhone];
    [self setMenuImage];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgMenu:nil];
    [super viewDidUnload];
}
@end

//
//  MedicalItemView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/16/12.
//
//

#import "MedicalItemView.h" 
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "NSAttributedString+Attributes.h"
#import "OHASBasicMarkupParser.h"
#import "OHAttributedLabel.h"
#import "MedicalItem.h"
#import "MedicalData.h"
#import "CreateMedicalItemViewController.h"
#import "PetModel.h"
#import "BlockAlertView.h"

@implementation MedicalItemView

- (id)initWithArray:(NSArray *)data withTitle:(NSString *)title andType:(NSString *)contentType
{
    self = [super init];
    if (self)
    {
        self.medicalItems = [[NSMutableArray alloc] initWithArray:data];
        self.objMedicalData = [[MedicalData alloc] init];
        self.title = title;
        self.type = title;
        self.contentType = contentType;

        [self initialize];
    }
    return self;
}

- (id)initWithData:(NSString *)data withTitle:(NSString *)title andType:(NSString *)contentType
{
    self = [super init];
    if (self)
    {
        self.strData = data;
        self.objMedicalData = [[MedicalData alloc] init];
        //NSLog(@"init with strData %@", strData);
        self.title = title;
        self.type = title;
        self.contentType = contentType;

        [self initialize];
    }
    return self;
}




- (void)initialize
{
    self.petModel = [[PetModel alloc] init];
    
    if (![self.contentType isEqualToString:kTypeTextView])
    {
        [self addButton];
    }
    else
    {
        UIButton *background = [UIButton buttonWithType:UIButtonTypeCustom];
        [background setImage:[UIImage imageNamed:@"btnSingleListItem.png"] forState:UIControlStateNormal];
        [background setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [background setFrame:CGRectMake(7, 25, 307, 51)];
        [background addTarget:self action:@selector(viewMedicalItem:) forControlEvents:UIControlEventTouchUpInside];
        background.backgroundColor = [UIColor clearColor];
        [self addSubview:background];

        //NSLog(@"there are %i number of items for this view", [self.medicalItems count]);
        self.lblData = [[UILabel alloc] init];
        self.lblData.text = self.strData;
        self.lblData.frame = CGRectMake(15, 22, 295, 51);
        self.lblData.textAlignment = UITextAlignmentLeft;
        self.lblData.backgroundColor = [UIColor clearColor];
        self.lblData.font = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
        self.lblData.textColor = [UIColor purinaDarkGrey];
        [self addSubview:self.lblData];

        //NSLog(@"strData : %@", self.objMedicalData.data);

        self.height = 75;
    }

    if (![self.contentType isEqualToString:kTypeTextView])
    {
        if ([self.medicalItems count] > 0)
        {
            self.count = [self.medicalItems count];
            [self createItems];
        }
        else
        {
            NSString *message = [NSString stringWithFormat:@"Tap plus button to add new %@", self.title];
            [self createMessage:message];
        }
    }

    [self addLabel];
}


- (void)createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:15]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:self.title]];

    OHAttributedLabel * lblMessage = [[OHAttributedLabel alloc] init];
    lblMessage.frame = CGRectMake(10, 55, 307, 100);
    lblMessage.attributedText = attrStr;
    lblMessage.backgroundColor = [UIColor clearColor];
    [self addSubview:lblMessage];

    self.height = 0;
}

- (void)addButton
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [addBtn setImage:[UIImage imageNamed:@"iconPlus.png"] forState:UIControlStateNormal];
    [addBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [addBtn setFrame:CGRectMake(285,25,29,30)];
    [addBtn addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
}

- (void)addLabel
{
    UILabel *lblTitle = [[UILabel alloc] init];
    if (![self.contentType isEqualToString:kTypeTextView]) lblTitle.frame = CGRectMake(10, 35, 175, 21);
    else lblTitle.frame = CGRectMake(10, 5, 175, 21);
    lblTitle.font = [UIFont fontWithName:kHelveticaNeue size:14.0f];
    lblTitle.textColor = [UIColor purinaDarkGrey];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = self.title;
    [self addSubview:lblTitle];
}

- (IBAction) viewMedicalItem:(id)sender
{
    //[self addMedItem];

    [self edit];
}

- (IBAction)buttonTouched:(id)sender
{
    NSLog(@"button touched");
    [self edit];
}



- (void)createItems
{
    
    for (int i = 0; i < [self.medicalItems count]; i++)
    {
        MedicalData* objMedicalData = [self.medicalItems objectAtIndex:i];
        [self createMedItem:i objMedicalData:objMedicalData];
        
        
        //NSLog(@"create");
    }
    
    
    self.height = self.count * 55;
    
//    for (int i = 0; i < [self.medicalItems count]; i++)
//    {
//        MedicalData* objMedicalData = [self.medicalItems objectAtIndex:i];
//        [self createMedItem:i objMedicalData:objMedicalData];
//
//
//        if ([self.objMedicalData.type isEqualToString:kTypeSingleItem]) lblLabel.frame = CGRectMake(15, (pos * 55) + 55, 150, 51);
//        else lblLabel.frame = CGRectMake(15, (pos * 55) + 55, 307, 51);
//        
//        if (![self.contentType isEqualToString:kTypeTextView]) background.frame = CGRectMake(7, (pos * 55) + 55, 307, 51);
//        else background.frame = CGRectMake(7, (pos * 55) + 35, 307, 51);
//        
//        
//
//        //NSLog(@"create");
//    }
//
//
//    self.height = self.count * 55;

}

- (void)createMedItem:(int)pos objMedicalData:(MedicalData *)data
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnSingleListItem.png"]];
    UIButton *btn;

    if (![self.contentType isEqualToString:kTypeTextView])
    {
        background.frame = CGRectMake(7, (pos * 55) + 55, 307, 51);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(7, (pos * 55) + 55, 307, 51);
    }
    else background.frame = CGRectMake(7, (pos * 55) + 35, 307, 51);
    [self addSubview:background];


    
    UILabel *lblLabel = [[UILabel alloc] init];
    lblLabel.text = data.name;
    if ([data.type isEqualToString:kTypeSingleItem]) lblLabel.frame = CGRectMake(15, (pos * 55) + 55, 150, 51);
    else lblLabel.frame = CGRectMake(15, (pos * 55) + 55, 195, 51);
    lblLabel.textAlignment = UITextAlignmentLeft;
    lblLabel.backgroundColor = [UIColor clearColor];
    lblLabel.font = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
    lblLabel.textColor = [UIColor purinaDarkGrey];
    [self addSubview:lblLabel];
    self.objMedicalData.guid = data.guid;
    
    if ([data.type isEqualToString:kMedicalTypeMedication] || [data.type isEqualToString:kMedicalTypeSurgery]  || [data.type isEqualToString:kMedicalTypeVaccination])
    {
        UILabel *lblValue = [[UILabel alloc] init];
        if ([data.type isEqualToString:kMedicalTypeMedication]) lblValue.text = data.dosage;
        if ([data.type isEqualToString:kMedicalTypeSurgery] || [data.type isEqualToString:kMedicalTypeVaccination]) lblValue.text = data.date;
        lblValue.frame = CGRectMake(215, (pos * 55) + 55, 90, 51);
        lblValue.textAlignment = UITextAlignmentRight;
        lblValue.backgroundColor = [UIColor clearColor];
        lblValue.font = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
        lblValue.textColor = [UIColor purinaDarkGrey];
        [self addSubview:lblValue];
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(medicalItemTapped:)];
    gestureRecognizer.numberOfTapsRequired = 2;
    [btn addGestureRecognizer:gestureRecognizer];
    [self addSubview:btn];
    self.height = (self.count -1) * 55;
    //NSLog(@"create items %i", self.height);
}

- (void)medicalItemTapped:(UIGestureRecognizer *)sender
{
    NSLog(@"tapped");
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Delete Medical Item" message:@"Are you sure you want to delete?"
                                                 delegate:self       cancelButtonTitle:@"OK"       otherButtonTitles:@"Cancel", nil];


    [alert show];


    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        BlockAlertView* confirm = [BlockAlertView alertWithTitle:@"Delete" message:@"Test Message"];
        [confirm setDestructiveButtonWithTitle:@"Confirm" block:^{

        }];

        [confirm show];
    }

    NSArray *subViewArray = alert.subviews;
    for(int x=0;x<[subViewArray count];x++){
        if([[[subViewArray objectAtIndex:x] class] isSubclassOfClass:[UILabel class]])
        {
            UILabel *label = [subViewArray objectAtIndex:x];
            label.textAlignment = UITextAlignmentCenter;
        }

    }

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) [self.petModel deleteMedicalItem:self.objMedicalData];

    NSLog(@"guid %@", self.objMedicalData.guid);
    [self.delegate deleteMedicalItem];
}



- (void) addMedItem
{
    [self.delegate createNewMedWithType:self.type andContentType:self.contentType];
}

- (void)edit
{
    NSLog(@"edit tapped");

    [self.delegate updateTextWithType:self.type withContentType:self.contentType andData:self.strData];
}

- (void) addNewItem:(MedicalData *)data
{
    [self createMedItem:self.count objMedicalData:data];
    self.count = self.count + 1;
    self.height = self.count * 55;
    //NSLog(@"ADD items %i", self.height);
}

- (void) updateNewItem:(MedicalData *)data
{
    NSLog(@"update new item %@", data);

    self.strData = data.data;
    self.lblData.text = self.strData;
}


@end

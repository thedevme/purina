//
//  ContactCardView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/7/12.
//
//

#import "ContactCardView.h"
#import "Constants.h"
#import "PetModel.h"

@implementation ContactCardView

- (id)initWithContactData:(ContactData *)data withType:(NSString *)type
{
    self = [self init];
    
    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"ContactCardView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.petModel = [[PetModel alloc] init];

        _strType = type;
        _clController = [[CoreLocationController alloc] init];
        
//        if (data != nil)
//        {
//            _arrContacts = [[NSArray alloc] initWithArray:data];
//            _objPrimaryContact = [_arrContacts objectAtIndex:0];
//            NSLog(@"init with contacts %@",_objPrimaryContact);
//        }

        self.objPrimaryContact = data;
        
        //[self setBackground];
        [self createLabels];
        [self createContact];
    }
    
    return self;
}

- (void) addContact:(ContactData *)contact
{
    
}

- (void)addContact:(NSString *)type withData:(ContactData *)data
{
    
}

- (void) setBackground
{
    UIImageView* imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contactCardTop.png"]];
    imgBackground.frame = CGRectMake(8,  0, 305, 124);
    
    [self addSubview:imgBackground];
}

- (void) createLabels
{
    if ([_strType isEqualToString:kVeterinarian]) _lblType.text = NSLocalizedString(@"Veterinarian", nil);
    else if ([_strType isEqualToString:kGroomer]) _lblType.text = NSLocalizedString(@"Groomer", nil);
    else if ([_strType isEqualToString:kKennel]) _lblType.text = NSLocalizedString(@"Kennel", nil);
}

- (void) createContact
{
   
    
    
    if (_objPrimaryContact != nil)
    {
        _lblName.text = [_objPrimaryContact name];
        _lblName.textAlignment = UITextAlignmentLeft;
        _lblName.textColor = [UIColor purinaDarkGrey];
        _lblName.backgroundColor = [UIColor clearColor];
        _lblName.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
        
        
        //NSString* strAddress = [NSString stringWithFormat:@"%@", [_objPrimaryContact streetAddress]];
        
        if (_objPrimaryContact != nil) _lblAddress.text = [_objPrimaryContact streetAddress];
        _lblAddress.textAlignment = UITextAlignmentLeft;
        _lblAddress.backgroundColor = [UIColor clearColor];
        _lblAddress.textColor = [UIColor purinaDarkGrey];
        _lblAddress.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];

        NSString* strCity = [NSString stringWithFormat:@"%@ %@ %i", [_objPrimaryContact city], [_objPrimaryContact state], [_objPrimaryContact zipCode]];

        if (_objPrimaryContact != nil) _lblCity.text = strCity;
        _lblCity.textAlignment = UITextAlignmentLeft;
        _lblCity.backgroundColor = [UIColor clearColor];
        _lblCity.textColor = [UIColor purinaDarkGrey];
        _lblCity.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];


        self.btnCard.frame = CGRectMake(15, 10, 292, 75);
    }
    else
    {
        UILabel* lblContactName = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 30)];

        lblContactName.text = [NSString stringWithFormat:@"Tap to add a %@", [self capitalizedFirstCharacter:_strType]];
        lblContactName.textAlignment = UITextAlignmentCenter;
        lblContactName.backgroundColor = [UIColor clearColor];
        lblContactName.textColor = [UIColor purinaDarkGrey];
        lblContactName.font = [UIFont fontWithName:kHelveticaNeueBold size:14.0f];
        [self addSubview:lblContactName];

        [self hideBtns];
        self.btnCard.frame = CGRectMake(15, 10, 292, 111);
    }
    
    _lblSeeAll.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    _lblSeeAll.textColor = [UIColor purinaDarkGrey];
    
    _lblType.font = [UIFont fontWithName:kHelveticaNeueCondBold size:18.0f];
    _lblType.textColor = [UIColor purinaRed];
}

- (NSString *)capitalizedFirstCharacter:(NSString *)str
{
    str = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]];
    return str;
}

- (void) hideBtns
{
    _btnCall.alpha = 0;
    _btnContact.alpha = 0;
    _btnEmail.alpha = 0;
    _btnMap.alpha = 0;
    _btnSeeAll.alpha = 0;
    _btnArrow.alpha = 0;
    _lblSeeAll.alpha = 0;
}



- (void) btnSelected:(id)sender
{
    if ([sender tag] == 0)
    {
        NSString *phoneStripped = [[_objPrimaryContact phone]
                                   stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString* phoneNo = [NSString stringWithFormat:@"tel:%@", phoneStripped];
        //NSLog(@"%@", phoneNo);
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneNo];
        [[UIApplication sharedApplication] openURL:phoneURL];
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_CALLCONTACT"];
    }
    else if ([sender tag] == 1)
    {
        CLLocationCoordinate2D location = [_clController getUsersCurrentPosition];
        NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %d", [_objPrimaryContact streetAddress], [_objPrimaryContact city], [_objPrimaryContact state], [_objPrimaryContact zipCode]];
        
        
        
        
        NSString *url;
        NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        
        if ( 6 == [[versionCompatibility objectAtIndex:0] intValue] )
        {
            url = [NSString stringWithFormat: @"http://maps.apple.com/maps?saddr=%f,%f&daddr=%@",
                         location.latitude, location.longitude,
                         [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
                         location.latitude, location.longitude,
                         [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
//        
//        
//        
//        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",
//                         location.latitude, location.longitude,
//                         [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        //NSLog(@"%@, %f %f", address, location.longitude, location.latitude);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        
        [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_MAPCONTACT"];
    }
    else if ([sender tag] == 2)
    {
        if ([_objPrimaryContact email] != nil || [[_objPrimaryContact email] isEqualToString:@""])
        {
            //NSLog(@"send email");
        }
        else
        {
            NSString* subject = @"";
            NSString* body = @"";
            NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
                                    [[_objPrimaryContact name] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                    [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
                                    [body  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
            
            [Flurry logEvent:@"00_NES_42646_PetHealthUD_IOS_EMAILCONTACT"];
        }
    }
    else if ([sender tag] == 3)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kViewList object:_strType];
    }
    else if ([sender tag] == 4)
    {
        if (_objPrimaryContact != nil) [[NSNotificationCenter defaultCenter] postNotificationName:@"viewContact" object:_objPrimaryContact];
        else [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewContact" object:_strType];
    }
}

- (IBAction)onCardTapped:(id)sender
{
    NSLog(@"contact type %@", self.strType);
    [self.delegate addContact:self.strType withData:self.objPrimaryContact];
}



@end

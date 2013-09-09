//
// Created by craigclayton on 11/30/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <CoreLocation/CoreLocation.h>
#import "PetContactView.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "NSString+StringUtil.h"
#import "CoreLocationController.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"
#import "OHAttributedLabel.h"


@implementation PetContactView

- (id)initWithContactData:(ContactData *)data withType:(NSString *)type
{
    self = [super init];

    if (self)
    {
        self.objPrimaryContact = data;
        self.petType = type;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self createLabels];
    [self createButtons];
    //[self createData];

    if (self.objPrimaryContact.name.length > 0)
    {
        [self createData];
    }
    else
    {
        self.iconEmail.alpha = 0.0f;
        self.iconMap.alpha = 0.0f;

        NSString *message = [NSString stringWithFormat:@"Tap here to add a %@", [self capitalizedFirstCharacter:self.petType]];
        [self createMessage:message];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateContact:) name:kEditPrimaryContact object:nil];
    //
}


- (void)createMessage:(NSString *)message
{
    NSString* strTypeTitle = [NSString stringWithFormat:@"%@", message];
    NSString* txt = strTypeTitle;
    NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
    [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:24]];
    [attrStr setTextColor:[UIColor purinaDarkGrey]];
    [attrStr setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
    [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:[self capitalizedFirstCharacter:self.petType]]];

    OHAttributedLabel * lblMessage = [[OHAttributedLabel alloc] init];
    lblMessage.frame = CGRectMake(20, 35, 307, 100);
    lblMessage.attributedText = attrStr;
    lblMessage.backgroundColor = [UIColor clearColor];
    [self addSubview:lblMessage];;
}


- (void) updateContact:(NSNotification *)note
{
    ContactData *objContactData = [note object];
    if ([objContactData.guid isEqualToString:self.objPrimaryContact.guid])
    {

        //NSLog(@"update contact strData pet contact view");
        self.objPrimaryContact = objContactData;
        [self reset];
        [self createData];
    }

}

- (void)reset
{
    self.lblType.text = @"";
    self.lblName.text = @"";
    self.lblAddress.text = @"";
    self.lblCity.text = @"";
    self.lblPhone.text = @"";
}

- (void) updateCard:(ContactData *)data
{
     self.objPrimaryContact = data;
    [self createData];
}

- (void)createData
{

    NSLog(@"init with cotact data %@", self.objPrimaryContact.name);
    NSLog(@"init with cotact street %@", self.objPrimaryContact.streetAddress);

    self.lblType.text = [NSString stringWithFormat:@"%@", [self capitalizedFirstCharacter:self.petType]];
    self.lblName.text = self.objPrimaryContact.name;
    self.lblAddress.text = NSLocalizedString([self.objPrimaryContact streetAddress], nil);
    self.lblCity.text = [NSString stringWithFormat:@"%@ %i", [self.objPrimaryContact city], [self.objPrimaryContact zipCode]];
    self.lblPhone.text = [NSString stringWithFormat:@"%@", [self.objPrimaryContact phone]];
//
//
//
//
    //if ([_arrContacts count] > 1) self.lblSeeAll.text = NSLocalizedString(@"See All",nil);
}






- (NSString *)capitalizedFirstCharacter:(NSString *)str
{
    str = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]];
    return str;
}



- (void)createLabels
{
    self.lblType = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 285, 27)];
    self.lblType.backgroundColor = [UIColor clearColor];
    self.lblType.textColor = [UIColor purinaRed];
    self.lblType.font = [UIFont fontWithName:kHelveticaNeueBold size:18.0f];
    [self addSubview:self.lblType];

    self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(20, 40-12, 285, 27)];
    self.lblName.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblName.textColor = [UIColor purinaDarkGrey];
    self.lblName.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblName];

    self.lblAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 58-12, 285, 27)];
    self.lblAddress.font = [UIFont fontWithName:kHelveticaNeueMed size:14.0f];
    self.lblAddress.textColor = [UIColor purinaDarkGrey];
    self.lblAddress.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblAddress];

    self.lblCity = [[UILabel alloc] initWithFrame:CGRectMake(20, 76-12, 285, 27)];
    self.lblCity.font = [UIFont fontWithName:kHelveticaNeueMed size:14.0f];
    self.lblCity.textColor = [UIColor purinaDarkGrey];
    self.lblCity.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblCity];

    self.lblPhone = [[UILabel alloc] initWithFrame:CGRectMake(20, 92-12, 285, 27)];
    self.lblPhone.font = [UIFont fontWithName:kHelveticaNeueMed size:14.0f];
    self.lblPhone.textColor = [UIColor purinaDarkGrey];
    self.lblPhone.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblPhone];

    self.lblSeeAll = [[UILabel alloc] initWithFrame:CGRectMake(80, 41, 285, 27)];
    self.lblSeeAll.font = [UIFont fontWithName:kHelveticaNeueMed size:14.0f];
    self.lblSeeAll.textColor = [UIColor purinaDarkGrey];
    self.lblSeeAll.textAlignment = UITextAlignmentRight;
    self.lblSeeAll.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblSeeAll];
}

- (void)createButtons
{
    self.iconEmail = [UIButton buttonWithType:UIButtonTypeCustom];

    if ([_objPrimaryContact email] == NULL)
    {
        self.iconEmail.alpha = 0.5;
    }
    else
    {
        [self.iconEmail addTarget:self action:@selector(iconSelected:)
                 forControlEvents:UIControlEventTouchDown];
    }
    //NSLog(@"%@", _objPrimaryContact);

    self.iconEmail.tag = 1;
    self.iconEmail.frame = CGRectMake(340, 0, 35, 35);
    [self.iconEmail setImage:[UIImage imageNamed:@"iconEmail.png"] forState:UIControlStateNormal];
    [self addSubview:self.iconEmail];

    self.iconMap = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconMap addTarget:self action:@selector(iconSelected:)
             forControlEvents:UIControlEventTouchDown];

    self.iconMap.tag = 0;
    self.iconMap.frame = CGRectMake(372, 0, 35, 35);
    [self.iconMap setBackgroundImage:[UIImage imageNamed:@"iconMap.png"] forState:UIControlStateNormal];
    [self addSubview:self.iconMap];

    self.imgSeeAll = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnTipArrow.png"]];
    self.imgSeeAll.frame = CGRectMake(372, 40, 30, 30);
    [self addSubview:self.imgSeeAll];

    self.imgLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalGreyLine.png"]];
    self.imgLine.frame = CGRectMake(15, -1, 386, 1);
    [self addSubview:self.imgLine];
}

- (void) iconSelected:(id)sender
{
    if ([sender tag] == 0)
    {
        CLLocationCoordinate2D location = [self.clController getUsersCurrentPosition];
        NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %i", [_objPrimaryContact streetAddress], [_objPrimaryContact city], [_objPrimaryContact state], [_objPrimaryContact zipCode]];

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
        NSLog(@"%@, %f %f", address, location.longitude, location.latitude);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    }
    else if ([sender tag] == 1)
    {

        NSLog(@"email icon selected %@", [_objPrimaryContact email]);

        if ([_objPrimaryContact email] != nil || [[_objPrimaryContact email] isEqualToString:@""])
        {
            NSLog(@"send email");
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
        }
    }
}



@end
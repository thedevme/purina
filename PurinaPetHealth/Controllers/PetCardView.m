//
//  PetCardView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 11/29/12.
//
//

#import "PetCardView.h"
#import "PetContactView.h"
#import "Constants.h"
#import "UIColor+PetHealth.h"
#import "PetData.h"
#import "PetContactData.h"
#import "ContactCardView.h"
#import "ContactData.h"
#import "PetModel.h"
#import "Contact.h"
#import "CoreDataStack.h"
#import "_EmergencyVet.h"

@implementation PetCardView
@synthesize avatar = _avatar;


- (id)initWithPetData:(PetData *)data
{
    self = [super init];
    if (self) {
        // Initialization code
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"PetCardView" owner:self options:nil];

        self.petModel = [[PetModel alloc] init];
        self.arrCards = [[NSMutableArray alloc] init];

        self = [nib objectAtIndex:0];
        self.objPetData = data;
        self.arrContacts = [[NSMutableArray alloc] initWithArray:self.objPetData.contacts];
        [self createContacts];
        [self setLabels];
        [self setData];
        [self setPetIcon];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"updatePetInfo" object:nil];

        NSLog(@"%@", self.objPetData.contacts);
        NSLog(@"name %@", self.objPetData.name);
        NSLog(@"kennel %@", self.objPetData.primaryKennel);
        NSLog(@"vet %@", self.objPetData.primaryVet);
        //NSLog(@"vet %@", [self.petModel getContactByID:self.objPetData.primaryVet]);
        NSLog(@"groomer %@", self.objPetData.primaryGroomer);
    }
    return self;
}

- (void) update:(NSNotification *)note
{
    if ([[[note object] guid] isEqualToString:self.objPetData.guid])
    {
        NSLog(@"hell the fuk ya thats me %@", self.objPetData.name);
        self.objPetData = [note object];

        [self setData];
        [self.arrContacts removeAllObjects];
        self.arrContacts = self.objPetData.contacts;


        for(UIView *subview in [self subviews]) {
            if([subview isKindOfClass:[PetContactView class]]) {
                [subview removeFromSuperview];
            }
        }

        [self createContacts];


    }
}

- (void) updateCard:(PetData *)data
{

    NSLog(@"update card done");
}

- (void) createModel
{
    _dataStack = [CoreDataStack coreDataStackWithModelName:@"PetModel" databaseFilename:@"PetModel.sqlite"];
    _dataStack.coreDataStoreType = CDSStoreTypeSQL;
}

- (void)setPetIcon
{
    UIImageView *backingViewForRoundedCorner = [[UIImageView alloc] initWithFrame:CGRectMake(74, 53, 135, 135)];
    backingViewForRoundedCorner.layer.cornerRadius = 8.0f;
    backingViewForRoundedCorner.clipsToBounds = YES;
    backingViewForRoundedCorner.backgroundColor = [UIColor clearColor];
    [self addSubview:backingViewForRoundedCorner];

    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 135, 135)];
    self.avatar.backgroundColor = [UIColor clearColor];
    self.avatar.image = [UIImage imageWithData:self.objPetData.imageData];
    [backingViewForRoundedCorner addSubview:self.avatar];
}

- (void)createContacts
{
    NSLog(@"groomer %@", [self getContactData:kGroomer]);
    NSLog(@"vet %@", [self getContactData:kVeterinarian]);
    NSLog(@"kennel %@", [self getContactData:kKennel]);

    for (int i = 0; i < 3; i++)
    {
        PetContactView* contactCardView;

        NSLog(@"pet data %@", self.objPetData.primaryVet);

        if (i == 0) contactCardView = [[PetContactView alloc] initWithContactData:[self getContactData:kVeterinarian] withType:kVeterinarian];
        if (i == 1) contactCardView = [[PetContactView alloc] initWithContactData:[self getContactData:kGroomer] withType:kGroomer];
        if (i == 2) contactCardView = [[PetContactView alloc] initWithContactData:[self getContactData:kKennel] withType:kKennel];

        contactCardView.frame = CGRectMake(55, 207 + (i * 110), 415, 130);
        contactCardView.tag = i;
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onContactedTapped:)];
        gestureRecognizer.numberOfTapsRequired = 1;
        [contactCardView addGestureRecognizer:gestureRecognizer];


        [self addSubview:contactCardView];
    }
}


- (void) getPetAge:(NSString *)bday
{
    if ([bday isEqualToString:@"NA"])
    {
        self.lblAge.text = @"-";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM d, yyyy"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:bday];

        NSString *age = [self age:dateFromString];
        self.lblAge.text = age;
    }
}


- (NSString *)age:(NSDate *)dateOfBirth {

    NSInteger years;
    NSInteger months;
    NSInteger days;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];

    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
            (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        years = [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        years = [dateComponentsNow year] - [dateComponentsBirth year];
    }

    NSLog(@"years:%d", years);

    if ([dateComponentsNow year] == [dateComponentsBirth year]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] > [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] < [dateComponentsBirth month]) {
        months = [dateComponentsNow month] - [dateComponentsBirth month] + 12;
    } else if ([dateComponentsNow year] > [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        months = 11;
    } else {
        months = [dateComponentsNow month] - [dateComponentsBirth month];
    }

    NSLog(@"months:%d", months);

    if ([dateComponentsNow year] == [dateComponentsBirth year] && [dateComponentsNow month] == [dateComponentsBirth month]) {
        days = [dateComponentsNow day] - [dateComponentsBirth day];
    }

    if (years == 0 && months == 0) {
        if (days == 1) {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"day", @"day")];
        } else {
            return [NSString stringWithFormat:@"%d %@", days, NSLocalizedString(@"days", @"days")];
        }
    } else if (years == 0) {
        if (months == 1) {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"mo.", @"mo.")];
        } else {
            return [NSString stringWithFormat:@"%d %@", months, NSLocalizedString(@"mos.", @"mos.")];
        }
    } else if ((years != 0) && (months == 0)) {
        if (years == 1) {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"yr", @"yr")];
        } else {
            return [NSString stringWithFormat:@"%d %@", years, NSLocalizedString(@"yrs", @"yrs")];
        }
    } else {
        if ((years == 1) && (months == 1)) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yr &", @"yr &"), months, NSLocalizedString(@"mo.", @"mo.")];
        } else if (years == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yr &", @"yr &"), months, NSLocalizedString(@"mos.", @"mos.")];
        } else if (months == 1) {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yrs &", @"yrs &"), months, NSLocalizedString(@"mo.", @"mo.")];
        } else {
            return [NSString stringWithFormat:@"%d %@ %d %@", years, NSLocalizedString(@"yrs &", @"yrs &"), months, NSLocalizedString(@"mos.", @"mos.")];
        }

    }

}



- (void)onContactedTapped:(UIGestureRecognizer *)sender
{
    [self.delegate editPet:self.objPetData];
}

- (NSString *)capitalizedFirstCharacter:(NSString *)str
{
    str = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]];
    return str;
}

- (ContactData *) getContactData:(NSString *)type
{
    //NSLog(@"%@", self.arrContacts);

    NSPredicate *typePredicate = [NSPredicate predicateWithFormat:@"type == %@", type];
    ContactData *objContactData = [[self.arrContacts filteredArrayUsingPredicate:typePredicate] lastObject];

    return objContactData;
}

- (void) setLabels
{
    self.lblName.font = [UIFont fontWithName:kHelveticaNeueCondBold size:32.0f];
    self.lblGender.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblBday.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblAge.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];
    self.lblBreed.font = [UIFont fontWithName:kHelveticaNeueBold size:16.0f];

    self.lblGender.textColor = [UIColor purinaDarkGrey];
    self.lblBday.textColor = [UIColor purinaDarkGrey];
    self.lblAge.textColor = [UIColor purinaDarkGrey];
    self.lblBreed.textColor = [UIColor purinaDarkGrey];

    self.lblTitleGender.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleBday.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleAge.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];
    self.lblTitleBreed.font = [UIFont fontWithName:kHelveticaNeue size:16.0f];

    self.lblTitleAge.textColor = [UIColor purinaRed];
    self.lblTitleGender.textColor = [UIColor purinaRed];
    self.lblTitleBday.textColor = [UIColor purinaRed];
    self.lblTitleBreed.textColor = [UIColor purinaRed];
    self.lblName.textColor = [UIColor purinaDarkGrey];

    [self.btnDelete setTitleColor:[UIColor purinaRed] forState:UIControlStateNormal];
    self.btnDelete.titleLabel.font = [UIFont fontWithName:kHelveticaNeueCondBold size:20.0f];
}

- (void)setData
{
    self.lblName.text = [self.objPetData name];
    self.lblBreed.text = [self.objPetData breed];
    self.lblGender.text = [self.objPetData gender];
    self.lblBday.text = self.objPetData.birthday;

    [self getPetAge:self.objPetData.birthday];

    self.avatar.image = [UIImage imageWithData:self.objPetData.imageData];
}

- (IBAction)onEditTapped:(id)sender
{
    [self.delegate editPet:self.objPetData];
}

- (IBAction)onDeleteTapped:(id)sender
{
    [self.delegate deletePet:self.objPetData];
}
@end

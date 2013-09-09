//
//  PetInfoView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 9/6/12.
//
//

#import "PetInfoView.h"
#import "PetData.h"
#import "AddPetViewController.h"

@implementation PetInfoView

@synthesize lblPetName;
@synthesize lblAge;
@synthesize lblBirthday;
@synthesize lblBreed;
@synthesize lblGender;
@synthesize objPetData;
@synthesize btnUpdate;
@synthesize btnShare;
@synthesize btnEdit;
@synthesize backingViewForRoundedCorner;


- (id)initWithData:(PetData *)data
{
    self = [super init];
    
    if (self)
    {
        objPetData = data;
        
        [self setBackground];
        [self setLabels];
        [self createAvatar];
        [self addButtons];
    }
    
    return self;
}

- (void) setBackground
{
    UIImageView* imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"petInfo"]];
    imgBackground.frame = CGRectMake(115,  25, 198, 105);
    
    [self addSubview:imgBackground];
}

- (void) setLabels
{
    NSDateFormatter* formatFullDate = [[NSDateFormatter alloc] init];
    [formatFullDate setDateFormat:@"MMMM dd, yyyy"];
    
    UILabel* lblGenderTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 40, 58, 21)];
    lblGenderTitle.text = NSLocalizedString(@"Gender:", nil);
    lblGenderTitle.textColor = [UIColor purinaRed];
    //@"Gender:";
    lblGenderTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lblGenderTitle];
    
    UILabel* lblBirthdayTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 58, 71, 21)];
    lblBirthdayTitle.text = NSLocalizedString(@"Birthday:", nil);
    lblBirthdayTitle.textColor = [UIColor purinaRed];
    //@"Birthday:";
    lblBirthdayTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lblBirthdayTitle];
    
    UILabel* lblAgeTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 76, 38, 21)];
    lblAgeTitle.text = NSLocalizedString(@"Age:", nil);//@"Age:";
    lblAgeTitle.textColor = [UIColor purinaRed];
    lblAgeTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lblAgeTitle];
    
    UILabel* lblBreedTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 94, 45, 21)];
    lblBreedTitle.text = NSLocalizedString(@"Breed:", nil);//@"Breed:";
    lblBreedTitle.textColor = [UIColor purinaRed];
    lblBreedTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lblBreedTitle];
    
    lblGenderTitle.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];
    lblBirthdayTitle.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];
    lblAgeTitle.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];
    lblBreedTitle.font = [UIFont fontWithName:kHelveticaNeue size:10.0f];
    
//    lblPetName = [[UILabel alloc] initWithFrame:(CGRectMake(13, 7, 279, 21))];
//    lblPetName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
//    lblPetName.backgroundColor = [UIColor clearColor];
//    lblPetName.text = objPetData.name;
    
    lblGender = [[UILabel alloc] initWithFrame:CGRectMake(175, 40, 128, 21)];
    lblGender.text = objPetData.gender;
    lblGender.textColor = [UIColor purinaDarkGrey];
    lblGender.font = [UIFont fontWithName:kHelveticaNeueBold size:10.0f];
    lblGender.backgroundColor = [UIColor clearColor];
    
    lblBirthday = [[UILabel alloc] initWithFrame:CGRectMake(180, 58, 128, 21)];
    lblBirthday.text = objPetData.birthday;
    lblBirthday.textColor = [UIColor purinaDarkGrey];
    lblBirthday.font = [UIFont fontWithName:kHelveticaNeueBold size:10.0f];
    lblBirthday.backgroundColor = [UIColor clearColor];
    
    lblAge = [[UILabel alloc] initWithFrame:CGRectMake(160, 76, 128, 21)];
    //lblAge.text = [self getPetAge];
    lblAge.textColor = [UIColor purinaDarkGrey];
    lblAge.font = [UIFont fontWithName:kHelveticaNeueBold size:10.0f];
    lblAge.backgroundColor = [UIColor clearColor];
    
    lblBreed = [[UILabel alloc] initWithFrame:CGRectMake(170, 94, 128, 21)];
    lblBreed.text = objPetData.breed;
    lblBreed.textColor = [UIColor purinaDarkGrey];
    lblBreed.font = [UIFont fontWithName:kHelveticaNeueBold size:10.0f];
    lblBreed.backgroundColor = [UIColor clearColor];
    
    [self addSubview:lblGender];
    [self addSubview:lblPetName];
    [self addSubview:lblAge];
    [self addSubview:lblBreed];
    [self addSubview:lblBirthday];

    [self getPetAge:self.objPetData.birthday];
    
    
    
    UIButton* btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnInfo addTarget:self action:@selector(editPetInfo:) forControlEvents:UIControlEventTouchUpInside];
    btnInfo.frame = CGRectMake(115,  25, 198, 105);
    [self addSubview:btnInfo];
}

- (void)editPetInfo:(id)sender
{
    [self.delegate editPet:self.objPetData];
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

//- (NSString *) getPetAge
//{
//    //int numAge = [self age:objPetData.birthday];
//    int numTotalAge;
//    int numFirstYrs = 2 * 10.5;
//    
//    NSLog(@"Age: %@", objPetData.birthday);
//    
//    if (objPetData.birthday != NULL)
//    {
//        if (numAge > 2)
//        {
//            int numRemainingAge = numAge - 2;
//            numTotalAge = numFirstYrs + (numRemainingAge * 4);
//        }
//        else
//        {
//            numTotalAge = numFirstYrs;
//        }
//        
//        return [NSString stringWithFormat:@"%i",numAge];
//    }
//    else
//    {
//        return @"";
//    }
//}

//- (NSInteger)age:(NSDate *)dateOfBirth
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
//    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
//
//    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
//        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
//        return [dateComponentsNow year] - [dateComponentsBirth year] - 1;
//    } else {
//        return [dateComponentsNow year] - [dateComponentsBirth year];
//    }
//}


- (void) addButtons
{
    btnUpdate = [UIButton buttonWithType:UIButtonTypeCustom];
    btnUpdate.frame = CGRectMake(20, 112, 76, 26);
    [btnUpdate setBackgroundImage:[UIImage imageNamed:@"updateBtn@2x.png"] forState:UIControlStateNormal];
    [btnUpdate addTarget:self action:@selector(onEditTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnUpdate];
    
    btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 0, 0);
    [btnShare setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnShare addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnShare];
    
    
    btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEdit.frame = CGRectMake(288, 30, 18, 20);
    [btnEdit setBackgroundImage:[UIImage imageNamed:@"myPetsPencil.png"] forState:UIControlStateNormal];
    [btnEdit addTarget:self action:@selector(onEditTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnEdit];
}

- (void)onEditTapped:(id)sender
{
    [self.delegate editPet:self.objPetData];
}

- (void) createAvatar
{
    backingViewForRoundedCorner = [[UIImageView alloc] initWithFrame:CGRectMake(7, 27, 101, 101)];
    backingViewForRoundedCorner.layer.cornerRadius = 8.0f;
    backingViewForRoundedCorner.clipsToBounds = YES;
    backingViewForRoundedCorner.backgroundColor = [UIColor redColor];
    
    if (objPetData.imageData == NULL)
    {
        //self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 86, 100)];
        UIImageView* imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addPhotoAvatar.png"]];
        imgIcon.frame = CGRectMake(18, 36, 78, 78);
        [self addSubview:imgIcon];
        
        self.avatar = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.avatar addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
        self.frame = CGRectMake(0, 0, 105, 105);
        
        UIButton* btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        btnIcon.frame = CGRectMake(7, 25, 105, 105);
        [btnIcon setBackgroundImage:[UIImage imageNamed:@"defaultPetIcon@2x.png"] forState:UIControlStateNormal];
        [btnIcon addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnIcon];
    }
    else
    {
        //self.avatar = [[UIImageView alloc] initWithImage:[UIImage imageWithData:objPetData.imageData]];
        self.avatar.frame = CGRectMake(0, 0, 78, 78);
        [self addSubview:backingViewForRoundedCorner];
        self.avatar.backgroundColor = [UIColor whiteColor];
        [backingViewForRoundedCorner addSubview:self.avatar];

        UIImageView* imgBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addPhotoAvatarBorder.png"]];
        imgBorder.frame = CGRectMake(18, 36, 78, 78);
        [self addSubview:imgBorder];
        
        self.avatar = [UIButton buttonWithType:UIButtonTypeCustom];
        //[[UIImageView alloc] initWithImage:[UIImage imageWithData:objPetData.imageData]];
        [self.avatar addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.avatar setBackgroundImage:[UIImage imageWithData:objPetData.imageData] forState:UIControlStateNormal];
        
        self.avatar.frame = CGRectMake(0, 0, 105, 105);
        [self addSubview:backingViewForRoundedCorner];
        self.avatar.backgroundColor = [UIColor whiteColor];
        [backingViewForRoundedCorner addSubview:self.avatar];
        
//        UIImageView* imgBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addPhotoAvatarBorder.png"]];
//        imgBorder.frame = CGRectMake(18, 36, 78, 78);
//        [self addSubview:imgBorder];
    }
}

- (void) updatePhoto:(UIImage *)avatar
{
    [self.avatar setBackgroundImage:avatar forState:UIControlStateNormal];
}


-(void)avatarClicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTapped" object:nil];
}


@end

//
//  PetDetailsView_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/20/12.
//
//

#import "PetDetailsView_iPad.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"
#import "IdentificationView_iPad.h"
#import "PetData.h"
#import "OHASBasicMarkupParser.h"
#import "NSAttributedString+Attributes.h"
#import "OHAttributedLabel.h"
#import "DDPageControl.h"
#import "PetModel.h"
#import "AppointmentData.h"
#import "MyPetsAppointmentView.h"
#import "BlockAlertViewLandscape.h"

@implementation PetDetailsView_iPad


- (id)init
{
    self = [super init];

    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"PetDetailsView_iPad" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.backgroundColor = [UIColor clearColor];
        self.petModel = [[PetModel alloc] init];

        [self setButtons];

    }

   return self;
}




- (void) initializeData:(PetData *)pet
{
    self.objPetData = pet;
    _numWidth = 274;
    //NSLog(@"init strData %@ ", pet);
    [self createIdentification];
    [self createMedical];
    [self createMedicalDetails];
    [self checkAppointments];

    [self createAppointmentScroller];
}

- (void) updatePet:(PetData *)pet
{
    self.objPetData = pet;
    //NSLog(@"init strData %@ ", pet);


    [self updateIdentification:self.objPetData];
    [self updateMedical:self.objPetData];

}

- (void)setButtons
{
    [self.btnIdentification setTitle:NSLocalizedString(@"Identification", nil) forState:UIControlStateNormal];
    self.btnIdentification.selected = YES;
    [self.btnIdentification setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
    [self.btnIdentification setTitleColor:[UIColor purinaRed] forState:UIControlStateSelected];
    self.btnIdentification.titleLabel.font = [UIFont fontWithName:kHelveticaNeueMedCond size:25.0f];

    [self.btnMedical setTitle:NSLocalizedString(@"Medical", nil) forState:UIControlStateNormal];
    [self.btnMedical setTitleColor:[UIColor purinaDarkGrey] forState:UIControlStateNormal];
    [self.btnMedical setTitleColor:[UIColor purinaRed] forState:UIControlStateSelected];
    self.btnMedical.titleLabel.font = [UIFont fontWithName:kHelveticaNeueMedCond size:25.0f];

    self.lblApptTitle.text = @"Appointments";
    self.lblApptTitle.textAlignment = UITextAlignmentCenter;
    self.lblApptTitle.textColor = [UIColor purinaRed];
    self.lblApptTitle.backgroundColor = [UIColor clearColor];
    self.lblApptTitle.font = [UIFont fontWithName:kHelveticaNeueMedCond size:25.0f];
}

- (void)showModal:(NSString *)type withData:(PetData *)pet
{
    
}

- (void) checkAppointments
{
    if (self.objPetData.appointments.count == 0)
    {
        NSString* strTypeTitle = [NSString stringWithFormat:@"You currently have no \nAppointments set today!"];
        NSString* txt = strTypeTitle;
        NSMutableAttributedString* attrStr = [OHASBasicMarkupParser attributedStringByProcessingMarkupInString:txt];
        [attrStr setFont:[UIFont fontWithName:kHelveticaNeueCondBold size:22]];
        [attrStr setTextColor:[UIColor purinaDarkGrey]];
        [attrStr setTextAlignment:kCTCenterTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
        [attrStr setTextColor:[UIColor purinaRed] range:[txt rangeOfString:@"Appointments"]];

        self.lblApptMessage.attributedText = attrStr;
    }
}


- (void)getPetAppointments
{
    NSArray *appointments = self.objPetData.appointments;

    self.arrAppointments = [[NSMutableArray alloc] init];
    self.arrAppointments.array = appointments;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 490, 274, 140)];
    [self createControls];
}

- (void) createControls
{
    self.pageControls = [[DDPageControl alloc] init];
    [self.pageControls addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageControls.frame =  CGRectMake(220, 605, 320, 30);
    [self.pageControls setOnColor: [UIColor purinaRed]] ;
    [self.pageControls setOffColor: [UIColor purinaDarkGrey]] ;
    [self.pageControls setType: DDPageControlTypeOnFullOffFull] ;
    [self.pageControls setIndicatorDiameter: 10.0f] ;
    //self.pageControls.alpha = 0.0f;
}

- (void) resetAppointments
{

    NSLog(@"reset appointments");

    for (UIView *i in self.scrollView.subviews)
        [i removeFromSuperview];



    self.objPetData = [self.petModel getPetByID:self.objPetData];
    NSArray *appointments = self.objPetData.appointments;

    self.arrAppointments = [[NSMutableArray alloc] init];
    self.arrAppointments.array = appointments;

    [self createAppointmentScroller];
}

- (void) createAppointmentScroller
{

    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;

    for (int i = 0; i < [self.arrAppointments count]; i++)
    {
        CGFloat xOrigin = i * 274;

        AppointmentData *objAppointmentData = [self.arrAppointments objectAtIndex:i];
        MyPetsAppointmentView* appointmentsView = [[MyPetsAppointmentView alloc] initWithData:objAppointmentData];
        appointmentsView.frame = CGRectMake(xOrigin, 0, 274, 140);

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(showAppointment:)];
        [appointmentsView addGestureRecognizer:tapGesture];
        //[appointmentsView addSubview:imageView];
        appointmentsView.backgroundColor = [UIColor clearColor];
        appointmentsView.tag = i;

        [self.scrollView addSubview:appointmentsView];
    }

    self.scrollView.contentSize = CGSizeMake(274 * self.arrAppointments.count, self.scrollView.frame.size.height);
    self.pageControls.currentPage = 0;
    self.pageControls.numberOfPages = self.arrAppointments.count;

    [self addSubview:self.scrollView];
    [self addSubview:self.pageControls];

    NSLog(@"create appt scroller");

    if (self.arrAppointments.count > 1)
    {
        self.pageControls.alpha = 1;
    }
    else
    {

        self.pageControls.alpha = 0;
    }

    if (self.arrAppointments.count == 0) self.lblApptMessage.alpha = 1.0f;
}

- (void) showAppointment:(id)sender
{

}

- (void)reset
{
    self.btnIdentification.selected = NO;
    self.btnMedical.selected = NO;

    self.identificationView.alpha = 0;
}

- (void)createIdentification
{
    self.identificationView = [[IdentificationView_iPad alloc] initWithPetData:self.objPetData];
    self.identificationView.frame = CGRectMake(55, 80, 360, 370);
    [self addSubview:self.identificationView];
}

- (void)createMedical
{
    self.medicalView = [[MedicalView_iPad alloc] initWithPetData:self.objPetData];
    self.medicalView.delegate = self;
    self.medicalView.frame = CGRectMake(55, 80, 360, 370);
    self.medicalView.alpha = 0.0f;
    [self addSubview:self.medicalView];
}

- (void) createMedicalDetails
{
    self.medicalDetailsView = [[MedicalItemsView_iPad alloc] init];
    self.medicalDetailsView.delegate = self;
    self.medicalDetailsView.frame = CGRectMake(55, 80, 360, 370);
    self.medicalDetailsView.alpha = 0.0f;
    [self addSubview:self.medicalDetailsView];
}

- (void)close
{
    self.medicalView.alpha = 1.0f;
    self.medicalDetailsView.alpha = 0.0f;
}

- (void)viewSelectedCategory:(NSString *)category
{
    
    NSPredicate *medicalPredicate = [NSPredicate predicateWithFormat:@"type == %@", category];
    NSArray *arrMedicalItems = [self.objPetData.medicalItems filteredArrayUsingPredicate:medicalPredicate];
    
    
    if (arrMedicalItems.count == 0)
    {
        BlockAlertViewLandscape *alert = [[BlockAlertViewLandscape alloc] init];


        alert.numMessageOffset = 120;
        alert.numTitleOffset = 15;
        alert.numHeightOffset = 90;
        [alert initWithTitle:@"Sorry" message:@"No medical items saved. Tap edit to add."];
        [alert setCancelButtonWithTitle:@"OK" block:nil];
        [alert showWithOneButton];
    }
    else
    {
        self.medicalDetailsView.alpha = 1.0f;
        self.medicalView.alpha = 0.0f;
        
        [self.medicalDetailsView initializeWithPetData:self.objPetData withContentType:[self setContentType:category] withType:category andData:nil];
    }
}


- (NSString *)setContentType:(NSString *)type
{
    NSString *contentType;

    if ([type isEqualToString:kMedicalTypeMedCondition])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeSurgery])
    {
        contentType = kTypeDatePicker;
    }
    else if ([type isEqualToString:kMedicalTypeAllergy])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeSpecialNeeds])
    {
        contentType = kTypeSingleItem;
    }
    else if ([type isEqualToString:kMedicalTypeMedication])
    {
        contentType = kTypeDosagePicker;
    }
    else if ([type isEqualToString:kMedicalTypeInsurance])
    {
        contentType = kTypeTextView;
    }
    else if ([type isEqualToString:kMedicalTypeVaccination])
    {
        contentType = kTypeDatePicker;
    }
    else if ([type isEqualToString:kMedicalTypeDiet])
    {
        contentType = kTypeTextView;
    }
    else if ([type isEqualToString:kMedicalTypeNotes])
    {
        contentType = kTypeTextView;
    }

    return contentType;
}

- (void) updateIdentification:(PetData *)data
{
    NSLog(@"update iden data %@", data.name);
    NSLog(@"update iden data %@", data.color);
    [self.identificationView resetIdentification:data];
}

- (void) updateMedical:(PetData *)data
{

    self.objPetData = data;

    //[self.medicalView resetMedical:data];
}

- (void)createNewMedWithType:(NSString *)type andContentType:(NSString *)contentType
{
    [self.delegate createNewMedWithType:type andContentType:contentType];
}

- (void)updateTextWithType:(NSString *)type withContentType:(NSString *)contentType andData:(NSString *)data {
    [self.delegate updateTextWithType:type withContentType:contentType andData:data];
}


- (IBAction) onNavigationTapped:(id)sender
{
    [self reset];
    
    if ([sender tag] == 0)
    {
        self.btnIdentification.selected = YES;
        self.identificationView.alpha = 1;
        self.medicalView.alpha = 0;
        self.medicalDetailsView.alpha = 0.0f;
    }
    else if ([sender tag] == 1)
    {
        self.btnMedical.selected = YES;
        self.medicalView.alpha = 1;
        self.identificationView.alpha = 0;
    }
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{

}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _pageControlBeingUsed = NO;

}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControlBeingUsed = NO;
    self.pageControls.currentPage = self.scrollView.contentOffset.x/274;

    self.numCurrentPage = self.scrollView.contentOffset.x / 274;
    self.pageControls.currentPage = self.numCurrentPage;
}


- (void) hideScroller
{
    self.scrollView.alpha = 0;
    self.pageControls.alpha = 0;
    //if (self.objCurrentPetData.appointments.count == 0)
}

- (void) showScroller
{
    self.scrollView.alpha = 1;
    //self.lblApptMessage.alpha = 0;
    if (self.arrAppointments.count > 1) self.pageControls.alpha = 1;
    else self.pageControls.alpha = 0;
}


- (IBAction)onEditTapped:(id)sender
{
    if ([sender tag] == 0)
    {
        NSLog(@"show identification form");

        [self.delegate showModal:@"identification" withData:self.objPetData];
    }
    else if ([sender tag] == 1)
    {
        NSLog(@"show medical form");
    }
}

- (void) updatePage
{
    _numWidth += _numWidth;
    _scrollView.contentOffset = CGPointMake(_numWidth, 0);
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.scrollView.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

- (IBAction) changePage:(id)sender
{
    NSLog(@"change page");
    CGRect frame;
    frame.origin.x = 274 * self.pageControls.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];

    self.pageControlBeingUsed = YES;
}
@end

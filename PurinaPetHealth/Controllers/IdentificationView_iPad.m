//
//  IdentificationView_iPad.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import "IdentificationView_iPad.h"
#import "IdentificationItem.h"
#import "PetData.h"
#import "UIColor+PetHealth.h"
#import "Constants.h"

@implementation IdentificationView_iPad

- (id)initWithPetData:(PetData *)pet
{
    self = [super init];
    if (self)
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"IdentificationView_iPad" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.objPetData = pet;
        
        [self initialize];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:@"updatePetInfo" object:nil];
        // Initialization code
    }
    return self;
}

- (void) update:(NSNotification *)note
{
    if ([[[note object] guid] isEqualToString:self.objPetData.guid])
    {
        NSLog(@"hell the fuk ya thats me %@", self.objPetData.name);
        self.objPetData = [note object];

        [self updatePetData];
    }
}


- (void) initialize
{
    [self createLabels];
    //[self createIdentificationItems];
}

- (void)createLabels
{
    [self updatePetData];


    self.lblNeutered.textColor = [UIColor purinaDarkGrey];
    self.lblNeutered.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleNeutered.textColor = [UIColor purinaDarkGrey];
    self.lblTitleNeutered.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblWeight.textColor = [UIColor purinaDarkGrey];
    self.lblWeight.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleWeight.textColor = [UIColor purinaDarkGrey];
    self.lblTitleWeight.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblColor.textColor = [UIColor purinaDarkGrey];
    self.lblColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleColor.textColor = [UIColor purinaDarkGrey];
    self.lblTitleColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblEyeColor.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleEyeColor.textColor = [UIColor purinaDarkGrey];
    self.lblTitleEyeColor.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblCoatMarkings.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleCoatMarkings.textColor = [UIColor purinaDarkGrey];
    self.lblTitleCoatMarkings.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblPrice.textColor = [UIColor purinaDarkGrey];
    self.lblPrice.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitlePrice.textColor = [UIColor purinaDarkGrey];
    self.lblTitlePrice.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];


    self.lblTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTagNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleTagNo.textColor = [UIColor purinaDarkGrey];
    self.lblTitleTagNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblChipNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleChipNo.textColor = [UIColor purinaDarkGrey];
    self.lblTitleChipNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblLicenseNo.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleLicenseNo.textColor = [UIColor purinaDarkGrey];
    self.lblTitleLicenseNo.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblPedigree.textColor = [UIColor purinaDarkGrey];
    self.lblPedigree.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitlePedigree.textColor = [UIColor purinaDarkGrey];
    self.lblTitlePedigree.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];

    self.lblOwnedSince.textColor = [UIColor purinaDarkGrey];
    self.lblOwnedSince.font = [UIFont fontWithName:kHelveticaNeueCondBold size:15.0f];
    self.lblTitleOwnedSince.textColor = [UIColor purinaDarkGrey];
    self.lblTitleOwnedSince.font = [UIFont fontWithName:kHelveticaNeue size:12.0f];
    NSLog(@"create labels");
}

- (void)updatePetData {


    self.lblWeight.text = @"";
    self.lblColor.text = @"";
    self.lblEyeColor.text = @"";
    self.lblCoatMarkings.text = @"";
    self.lblPrice.text = @"";
    self.lblTagNo.text = @"";
    self.lblChipNo.text = @"";
    self.lblLicenseNo.text = @"";
    self.lblPedigree.text = @"";
    self.lblOwnedSince.text = @"";



    if ([self.objPetData.gender isEqualToString:@"Female"]) self.lblTitleNeutered.text = @"Spayed";
    else self.lblTitleNeutered.text = @"Neutered";

    self.lblNeutered.text = self.objPetData.spayedNeutered;
    if (![self.objPetData.weight isEqualToString:@"NA"]) self.lblWeight.text = self.objPetData.weight;
    if (![self.objPetData.color isEqualToString:@"NA"]) self.lblColor.text = self.objPetData.color;
    if (![self.objPetData.eyeColor isEqualToString:@"NA"]) self.lblEyeColor.text = self.objPetData.eyeColor;
    if (![self.objPetData.coatMarkings isEqualToString:@"NA"]) self.lblCoatMarkings.text = self.objPetData.coatMarkings;
    if (![self.objPetData.price isEqualToString:@"NA"]) self.lblPrice.text = self.objPetData.price;
    if (![self.objPetData.tagNo isEqualToString:@"NA"]) self.lblTagNo.text = self.objPetData.tagNo;
    if (![self.objPetData.chipNo isEqualToString:@"NA"]) self.lblChipNo.text = self.objPetData.chipNo;
    if (![self.objPetData.licenseNo isEqualToString:@"NA"]) self.lblLicenseNo.text = self.objPetData.licenseNo;
    if (![self.objPetData.pedigree isEqualToString:@"NA"]) self.lblPedigree.text = self.objPetData.pedigree;
    if (![self.objPetData.owned isEqualToString:@"NA"]) self.lblOwnedSince.text = self.objPetData.owned;
}

- (void)createIdentificationItems 
{
     for (int i = 0; i < self.arrLabels.count; i++)
     {
         IdentificationItem* item = [[IdentificationItem alloc] initWithLabel:[self.arrLabels objectAtIndex:i] andData:[self.arrValues objectAtIndex:i]];
         item.frame = CGRectMake(0, (i * 55) + 20, 307, 51);
         [self.scroller addSubview:item];
     }

    [self.scroller setContentSize:CGSizeMake(self.frame.size.width, (self.arrLabels.count * 55) + 20)];
}

- (void)resetIdentification:(PetData *)data
{
    self.objPetData = nil;
    self.objPetData = data;

    //NSLog(@"reset identification");
    [self updatePetData];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

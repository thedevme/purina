//
//  MedItemView.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/24/12.
//
//

#import "MedItemView.h"
#import "MedicalData.h"

@implementation MedItemView

- (id)initWithData:(MedicalData *)data
{
    self = [super init];
    
    if (self)
    {
        self.objMedicalData = data;
        
        [self setBackground];
        [self createItem];
    }
    
    return self;
}

- (void) setBackground
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btnSingleListItem.png"]];
    
    [self addSubview:background];
}


- (void) createItem
{
    
    
//    UILabel *lblLabel = [[UILabel alloc] init];
//    lblLabel.text = self.objMedicalData.name;
//
//    lblLabel.textAlignment = UITextAlignmentLeft;
//    lblLabel.backgroundColor = [UIColor clearColor];
//    lblLabel.font = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
//    lblLabel.textColor = [UIColor purinaDarkGrey];
//    [self addSubview:lblLabel];
//
//    if ([self.objMedicalData.type isEqualToString:kMedicalTypeMedication] || [self.objMedicalData.type isEqualToString:kMedicalTypeSurgery]  || [self.objMedicalData.type isEqualToString:kMedicalTypeVaccination])
//    {
//        UILabel *lblValue = [[UILabel alloc] init];
//        if ([self.objMedicalData.type isEqualToString:kMedicalTypeMedication]) lblValue.text = self.objMedicalData.dosage;
//        if ([self.objMedicalData.type isEqualToString:kMedicalTypeSurgery] || [self.objMedicalData.type isEqualToString:kMedicalTypeVaccination]) lblValue.text = self.objMedicalData.date;
//        //lblValue.frame = CGRectMake(140, (pos * 55) + 55, 150, 51);
//        lblValue.textAlignment = UITextAlignmentRight;
//        lblValue.backgroundColor = [UIColor clearColor];
//        lblValue.font = [UIFont fontWithName:kHelveticaNeueBold size:15.0f];
//        lblValue.textColor = [UIColor purinaDarkGrey];
//        [self addSubview:lblValue];
//    }
}

@end

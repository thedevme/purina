//
//  IdentificationView_iPad.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/21/12.
//
//

#import <UIKit/UIKit.h>

@class PetData;

@interface IdentificationView_iPad : UIView

@property(nonatomic, strong) UIScrollView *scroller;
@property(nonatomic, strong) PetData *objPetData;
@property(nonatomic, strong) NSArray *arrLabels;
@property(nonatomic, strong) NSMutableArray *arrValues;

@property (strong, nonatomic) IBOutlet UILabel *lblNeutered;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) IBOutlet UILabel *lblColor;
@property (strong, nonatomic) IBOutlet UILabel *lblEyeColor;
@property (strong, nonatomic) IBOutlet UILabel *lblCoatMarkings;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTagNo;
@property (strong, nonatomic) IBOutlet UILabel *lblChipNo;
@property (strong, nonatomic) IBOutlet UILabel *lblLicenseNo;
@property (strong, nonatomic) IBOutlet UILabel *lblPedigree;
@property (strong, nonatomic) IBOutlet UILabel *lblOwnedSince;


@property (strong, nonatomic) IBOutlet UILabel *lblTitleNeutered;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleWeight;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleColor;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleEyeColor;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleCoatMarkings;
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleTagNo;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleChipNo;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleLicenseNo;
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePedigree;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleOwnedSince;



- (id)initWithPetData:(PetData *)pet;

- (void)resetIdentification:(PetData *)data;

@end

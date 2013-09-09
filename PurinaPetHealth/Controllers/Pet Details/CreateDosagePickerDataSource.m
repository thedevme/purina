//
//  CreateDosagePickerDataSource.m
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/17/12.
//
//

#import <IBAForms/IBAForms.h>
#import "CreateDosagePickerDataSource.h"
#import "Constants.h"
#import "MedicalData.h"

@implementation CreateDosagePickerDataSource 

- (id) initWithModel:(id)aModel
{
    if ((self = [super initWithModel:aModel]))
    {
        IBAFormFieldStyle *style = [[IBAFormFieldStyle alloc] init];
        style.labelTextColor = [UIColor darkGrayColor];
        style.labelFont = [UIFont fontWithName:kHelveticaNeueCondBold size:12.0f];
        style.labelTextAlignment = UITextAlignmentLeft;
        style.valueTextColor = [UIColor darkGrayColor];
        style.valueBackgroundColor = [UIColor clearColor];
        style.labelFrame = CGRectMake(IBAFormFieldLabelX, IBAFormFieldLabelY, IBAFormFieldLabelWidth + 100, IBAFormFieldLabelHeight);
        style.labelBackgroundColor = [UIColor clearColor];
        style.activeColor = [UIColor clearColor];
        style.valueTextAlignment = UITextAlignmentRight;
        self.objMedicalData = [[MedicalData alloc] init];

        [self createApptTitle:style];
        [self createDosage:style];
    }

    return self;
}

- (void) createApptTitle:(IBAFormFieldStyle *)style
{
    IBAFormSection *titleSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    titleSection.formFieldStyle = style;

    titleSection.headerView.backgroundColor = [UIColor redColor];
    [titleSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"name" title:@"Name"]];
}

- (void) createDosage:(IBAFormFieldStyle *)style
{
    IBAFormSection *dosageSection = [self addSectionWithHeaderTitle:nil footerTitle:nil];
    dosageSection.formFieldStyle = style;

    dosageSection.headerView.backgroundColor = [UIColor redColor];
    [dosageSection addFormField:[[IBATextFormField alloc] initWithKeyPath:@"dosage" title:@"Dosage"]];
}

- (void)formField:(IBAFormField *)formField didSetValue:(id)value
{
    //NSLog(@"key path %@", [formField keyPath]);
}

- (void)setModelValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setModelValue:value forKeyPath:keyPath];

    self.objMedicalData.name = [self.model valueForKeyPath:@"name"];
    self.objMedicalData.dosage = [self.model valueForKeyPath:@"dosage"];

    //NSLog(@"set value dosage %@", [self.model valueForKeyPath:@"dosage"]);
    //NSLog(@"set value name %@", [self.model valueForKeyPath:@"name"]);
    [self.delegate saveMedialDosage:self.objMedicalData];
}

@end

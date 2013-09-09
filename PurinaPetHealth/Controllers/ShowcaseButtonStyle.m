//
// Copyright 2010 Itty Bitty Apps Pty Ltd
// 
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
// file except in compliance with the License. You may obtain a copy of the License at 
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "ShowcaseButtonStyle.h"


@implementation ShowcaseButtonStyle

- (id)init {
	if (self = [super init])
    {
        self.valueTextColor = [UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.0];
		self.valueFont = [UIFont boldSystemFontOfSize:14];
		self.valueFrame = CGRectMake(0, 8, 150, 30);
		self.valueTextAlignment = UITextAlignmentLeft;
		self.valueAutoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
		self.labelTextColor = [UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.0];
		self.labelFont = [UIFont boldSystemFontOfSize:14];
		self.labelFrame = CGRectMake(150, 8, 150, 30);
		self.labelTextAlignment = UITextAlignmentRight;
		self.labelAutoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
	
	return self;
}

@end

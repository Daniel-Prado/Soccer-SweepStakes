//
//  PorraDetail2CustomCell.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PorraDetail2CustomCell : UITableViewCell {
	
	UILabel *lblAtributo;
	UILabel *lblValor;
}

@property (nonatomic, retain) IBOutlet UILabel *lblAtributo;
@property (nonatomic, retain) IBOutlet UILabel *lblValor;

@end

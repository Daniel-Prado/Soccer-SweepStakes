//
//  PorraCustomCell.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PorraCustomCell.h"


@implementation PorraCustomCell
@synthesize lblApuesta, escudoEquipoUno, escudoEquipoDos, lblResultado;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[escudoEquipoUno release];
	[escudoEquipoDos release];
	[lblResultado release];
	[lblApuesta release];
    [super dealloc];
}


@end

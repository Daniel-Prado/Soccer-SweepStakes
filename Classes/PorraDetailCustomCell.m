//
//  PorraDetailCustomCell.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PorraDetailCustomCell.h"


@implementation PorraDetailCustomCell

@synthesize lblResultado,lblEquipoUno,lblEquipoDos,escudoEquipoUno,escudoEquipoDos;

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
	
	[lblEquipoUno release];
	[lblEquipoDos release];
	[lblResultado release];
	[escudoEquipoUno release];
	[escudoEquipoDos release];
	
    [super dealloc];
}


@end

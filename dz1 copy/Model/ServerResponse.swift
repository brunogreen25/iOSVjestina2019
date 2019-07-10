//
//  ServerResponse.swift
//  dz1
//
//  Created by five on 6/26/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
enum ServerResponse: Int{
    case UNAUTHORIZED=401
    case FORBIDDEN=403
    case NOT_FOUND=404
    case BAD_REQUEST=400
    case OK=200
}

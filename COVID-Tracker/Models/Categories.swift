//
//  Categories.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/9/20.
//

import Foundation


enum Region: String, CaseIterable, Hashable {
    case us, states
}



enum SelectedState: String, CaseIterable, Hashable {
    case al, ak, az, ar, ca, co, ct, de, fl, ga, hi, id, il, IN, ia, ks, ky, la, me, md, ma, mi, mn, ms, mo, mt, ne, nv, nh, nj, nm, ny, nc, nd, oh, ok, pa, ri, sc, sd, tn, tx, ut, vt, va, wa, wv, wi, wy
}



enum DataFrequency: String, CaseIterable, Hashable {
    case daily, current
}



enum DataCriteria: String, CaseIterable, Hashable {
    case positiveIncrease, deathIncrease, negativeIncrease, hospitalizedIncrease, positive, death, negative
}


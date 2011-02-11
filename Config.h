/*
 *  Config.h
 *  FlikrImageViewer
 *
 *  Created by zhangdong on 1/18/11.
 *  Copyright 2011 mertef.wordpress.com. All rights reserved.
 *
 */
#ifndef _CONFIG_H_
#define _CONFIG_H_
/*
 <xs:attribute name= action  type= xs:string  use= optional />
 <xs:attribute name= country  type= xs:string  use= optional />
 <xs:attribute name= encoding  type= xs:string  use= optional />
 <xs:attribute name= guid  type= xs:string  use= optional />
 <xs:attribute name= language  type= xs:string  use= optional />
 <xs:attribute name= location  type= xs:string  use= optional />
 <xs:attribute name= num_res  type= xs:integer  use= optional />
 <xs:attribute name= offset  type= xs:integer  use= optional />
 <xs:attribute name= output  type= xs:string  use= optional />
 <xs:attribute name= page  type= xs:integer  use= optional />
 <xs:attribute name= product_type  type= xs:string  use= optional />
 <xs:attribute name= property_type  type= xs:string  use= optional />
 <xs:attribute name= sort  type= xs:string  use= optional />
 */


//#import "JSON/JSON.h"

static NSString* const header_action   = @"action";
static NSString* const header_country =  @"country";
static NSString* const header_encoding=  @"encoding";
static NSString* const header_guid  =  @"guid";
static NSString* const header_language =  @"language";
static NSString* const header_location  =  @"location";
static NSString* const header_num_res =  @"num_res";
static NSString* const header_offset  =  @"offset";
static NSString* const header_page  =  @"page";

static NSString* const header_output  =  @"output";
static NSString* const header_product_type   =  @"product_type";
static NSString* const header_property_type   =  @"property_type";
static NSString* const header_sort   =  @"sort";


static NSString* const header_version   =  @"version"  ;
static NSString* const header_pretty    =  @"pretty"  ;
static NSString* const header_callback   =  @"callback"  ;

static NSString*  const CONST_REFRESH   =  @"Refresh";  





#endif

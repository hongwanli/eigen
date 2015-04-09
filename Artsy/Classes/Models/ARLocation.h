@interface ARLocation : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *streetAddress;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *postalCode;

@property (nonatomic, copy, readonly) NSString *phone;

@property (nonatomic, readonly) BOOL publiclyViewable;

@end

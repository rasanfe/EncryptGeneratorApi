forward
global type nvo_coderobject from coderobject
end type
end forward

global type nvo_coderobject from coderobject
end type
global nvo_coderobject nvo_coderobject

type variables
Encoding iEncoding = EncodingUTF8!
end variables

forward prototypes
public function string of_base64urlencode (string as_value)
public function string of_base64urldecode (string as_value)
end prototypes

public function string of_base64urlencode (string as_value);Blob lb_value
String ls_encode

lb_value = blob(as_value, iEncoding)

ls_encode = base64urlencode(lb_value)

RETURN ls_encode
end function

public function string of_base64urldecode (string as_value);Blob lb_value
String ls_decode
ULong lul_len

// allocate decoded buffer
lul_len = Len(as_value)
lb_value = Blob(Space(lul_len))

lb_value = base64urldecode(as_value)

ls_decode = String(BlobMid(lb_value, 1, lul_len), iEncoding)

RETURN ls_decode

end function

on nvo_coderobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_coderobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


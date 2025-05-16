forward
global type nvo_jsongenerator from jsongenerator
end type
end forward

global type nvo_jsongenerator from jsongenerator
end type
global nvo_jsongenerator nvo_jsongenerator

type variables
Long il_RootObject
end variables

forward prototypes
public function long of_additemstring (string as_key, string as_value)
public function string of_getjsonstring ()
private function string of_replaceall (string as_source, string as_replaced, string as_new)
end prototypes

public function long of_additemstring (string as_key, string as_value);Long ll_RootObject

ll_RootObject = AddItemString(il_RootObject, as_key, as_value)

RETURN ll_RootObject
end function

public function string of_getjsonstring ();String ls_jsonString

//Cambio Comillas Dobles por Simples
ls_jsonString = char(34)+of_replaceall(GetJsonString(), '"', "'")+char(34)

Return ls_jsonString
end function

private function string of_replaceall (string as_source, string as_replaced, string as_new);// Esta funcion reemplaza todas las ocurrencias de as_replaced por as_new en as_source y lo devuelve

Long ll_StartPos=1

// Find the first occurrence of as_replaced.
ll_StartPos = Pos(as_source, as_replaced, ll_StartPos)

// Only enter the loop if you find as_replaced.
DO WHILE ll_StartPos > 0
	   // Replace as_replaced with as_new.
    as_source = Replace(as_source, ll_StartPos, Len(as_replaced), as_new)
      // Find the next occurrence of as_replaced. 
	ll_StartPos = Pos(as_source, as_replaced, ll_StartPos+Len(as_new))
LOOP

RETURN as_source  
end function

on nvo_jsongenerator.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_jsongenerator.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;il_RootObject = CreateJsonObject ()
end event


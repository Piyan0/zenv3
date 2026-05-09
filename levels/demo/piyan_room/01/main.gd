extends Map


func _ready():
	super._ready() 
	x.callv([])
	
 
func x(y=1, z=2):
	print("@11")
	printt(y,z)

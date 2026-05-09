class_name DialoguePortraitData


func get_data():
    return _get_portrait_data()
    
    
func _get_portrait_data():
    var data = {}
    data["fred"] = {
        "name" : "Fred",
        "img_id" : "img_fred_portrait"
    }
    data["chloe"] = {
        "name" : "Chloe",
        "img_id" : "img_chloe_portrait"
    }
    
    return data
    
    